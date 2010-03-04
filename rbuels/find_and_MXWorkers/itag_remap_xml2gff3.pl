#!/usr/bin/env perl
use strict;
use warnings;
use autodie ':all';

use Carp;
use Getopt::Std;

use 5.10.0;


my ($outfile,@dirs) = @ARGV;
@dirs or die "must provide a list of directories\n";

my $donefile = 'xml2gff.already_done';

my $jobs = parallel_gthxml_to_gff3->new( donefile => $donefile, outfile => $outfile, dirs => \@dirs );
$jobs->max_workers( 12 );
$jobs->run;

exit;


#######  PACKAGES ##########################


BEGIN {
package parallel_gthxml_to_gff3;
use Moose;
use MooseX::Types::Path::Class;
use File::Flock;
use Path::Class;
use autodie ':all';

use POSIX;
use DB_File;

with 'MooseX::Workers';

# file where we store which xml files we have already processed
has 'donefile'   => ( is => 'ro',
                      isa => 'Path::Class::File',
                      required => 1,
                      coerce => 1,
                     );

# append our gff3 output to this file
has 'outfile'    => ( is => 'ro',
                      isa => 'Path::Class::File',
                      required => 1,
                      coerce => 1,
                     );

# keep a hashref of what files were done when we started,
# parsed from our donefile on program start
has 'files_done' => ( is => 'ro',
                      isa => 'HashRef',
                      lazy_build => 1,
                      traits => ['Hash'],
                      handles => {
                          is_done => 'get'
                         },
                     ); sub _build_files_done {
                         my ( $self ) = @_;

                         return {} unless -f $self->donefile;

			 print "indexing donefile ... ";
                         tie my %done, 'DB_File', $self->donefile.'.index', O_CREAT|O_RDWR;
                         my $d = $self->donefile->openr;
                         $done{ $_ } = 1 while <$d>;
			 print "done.\n";
                         return \%done;
                     }

#arrayref of dirs we are searching for files
has 'dirs'  => ( is => 'ro',
                 isa => 'ArrayRef',
                 required => 1,
                );

# run a find process to find the XML files we want
has 'find_handle' => ( is => 'ro',
                       isa => 'FileHandle',
                       lazy_build => 1,
                      ); sub _build_find_handle {
                          open my $f, "ssh eggplant find ".join(' ',map dir($_)->absolute, @{shift->dirs})." -type f -and -name '*.xml' |";
                          return $f;
                      }

# wrap MX::Workers enqueue to just take an xml file name, and generate
# the worker for it
around enqueue => sub {
    my ( $orig, $self, $xml_file ) = @_;

    if( $self->is_done( $xml_file ) ) {
	print "$xml_file skipped\n";
    }
    print "$xml_file queued ...\n";

    $self->$orig(sub {
        my $gff3_out_file = File::Temp->new;
        $gff3_out_file->close;
        eval {
            GTH_XML_2_GFF3->gthxml_to_gff3( $xml_file, "$gff3_out_file" );
        };
        if( $@ ) {
            warn "$xml_file parse failed:\n$@";
        } else {
            # dump the converted results to our output file
            open my $gff3_fh,'<', "$gff3_out_file";
            { my $l = File::Flock->new( $self->outfile );
              my $out_fh = $self->outfile->open('>>');
	      while( <$gff3_fh> ) {
		  unless( /^##gff-version/ ) {
		      $out_fh->print($_);
		  }
	      }
          }

            # record this file as done
            { my $l = File::Flock->new( $self->donefile );
              $self->donefile->open('>>')->print("$xml_file\n")
	    }
        }
    });
};

sub run {
    my $self = shift;

    # run find first
    my $files = $self->find_handle;

    # print just one gff3 header in the outfile
    $self->outfile->open('>>')->print("##gff-version 3\n");

    # now queue the first set of jobs
    for (1 .. $self->max_workers ) {
        my $xml_file = <$files>;
	chomp $xml_file;
        last unless defined $xml_file;
        $self->enqueue($xml_file);
    }
    POE::Kernel->run;
}

#sub worker_done    { shift; warn join ' ', @_; }
sub worker_done {
    my $self = shift;
    for( 1, 2 ) {
	if( my $xml_file = $self->find_handle->getline ) {
	    chomp $xml_file;
	    $self->enqueue( $xml_file );
	}
    }
}

# sub worker_manager_start { warn 'started worker manager' }
# sub worker_manager_stop  { warn 'stopped worker manager' }
# sub max_workers_reached  { warn 'max workers reached' }

sub worker_stdout  { shift; warn join ' ', @_; }
sub worker_stderr  { shift; warn join ' ', @_; }
sub worker_error   { shift; warn join ' ', @_; }
# sub worker_started { shift; warn join ' ', @_; }
# sub sig_child      { shift; warn join ' ', @_; }

no Moose;

