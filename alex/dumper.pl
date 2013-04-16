package Contact;

use Moose;

has firstname => ( is => 'ro', isa => 'Str' );
has lastname  => ( is => 'ro', isa => 'Str' );

package Company;

use Moose;

has name => ( is => 'ro', isa => 'Str', required => 1, );
has contacts => (
    is      => 'ro',
    isa     => 'ArrayRef',
    traits  => ['Array'],
    default => sub { [] },
    handles => {
        all_contacts => 'elements',
        add_contact  => 'push',
    },
);

package main;
use Data::Tabular::Dumper;
use Data::Tabular::Dumper::CSV;

my $company = Company->new( name => "foo" );

my $contact = Contact->new( firstname => 'foo', lastname => 'bar' );
$company->add_contact($contact);

my $dumper = Data::Tabular::Dumper->open(
                        CSV => [ "out.csv", {} ],
);

# $dumper->dump( $company->contacts ); # won't accept blessed objects, just ref HASH/ARRAY

# brute force works
$dumper->dump( unbless($company->contacts) );
$dumper->close();

