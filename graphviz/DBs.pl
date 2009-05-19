#!/usr/bin/perl

# http://github.com/jhannah/sandbox / graphviz

use strict;
use GraphViz;

my %settings = ( fontname => 'Courier', fontsize => 9, shape => 'box' );
my $sourcedir = '/home/jhannah/src/Omni2';

my $g = GraphViz->new();

# grep -E 'sub|mysql' DB.pm
pair('connect_omnihub_dev()',              'MySQL omnihub@dev');
pair('connect_omnihub_qa()',               'MySQL omnihub@qa');
pair('connect_omnihub_intranet1()',        'MySQL omnihub@omares-intranet1');
pair('connect_omnihub_intranet2()',        'MySQL omnihub@omares-intranet2');
pair('connect_omnihub_prod()',             'MySQL omnihub@omares-intranet2');
pair('connect_omnihub_l3omnihub1()',       'MySQL omnihub@l3omnihub1');
pair('connect_omnihub_l3omnihub2()',       'MySQL omnihub@l3omnihub2');
pair('connect_omnihub_dev_dbic()',         'MySQL omnihub@dev');
pair('connect_omnihub_prod_dbic()',        'MySQL omnihub@omares-intranet2');
pair('connect_omnihub_l3omnihub1_dbic()',  'MySQL omnihub@l3omnihub1');
pair('connect_omnihub_l3omnihub2_dbic()',  'MySQL omnihub@l3omnihub2');
pair('connect_omnihub_qa_dbic()',          'MySQL omnihub@qa');
pair('connect_omnihub()',                  'connect_omnihub_prod()');
pair('connect_omnihub()',                  'connect_omnihub_qa()');
pair('connect_omnihub()',                  'connect_omnihub_dev()');
pair('connect_omnihub()',                  'connect_omnihub_l3omnihub1()');
pair('connect_omnihub()',                  'connect_omnihub_intranet2()');
pair('connect_omnihub_dbic()',             'connect_omnihub_prod_dbic()');
pair('connect_omnihub_dbic()',             'connect_omnihub_l3omnihub1_dbic()');
pair('connect_omnihub_dbic()',             'connect_omnihub_l3omnihub2_dbic()');
pair('connect_omnihub_dbic()',             'connect_omnihub_qa_dbic()');
pair('connect_omnihub_dbic()',             'connect_omnihub_dev_dbic()');
pair('connect_rt()',                       'MySQL rt3@rt');

pair('connect_pms()',                      'connect_pms_prod()');
pair('connect_pms()',                      'connect_pms_qa()');
pair('connect_pms()',                      'connect_pms_dev()');
pair('connect_pms_dbic()',                 'MS-SQL production PMSs');
pair('connect_pms_qa_dbic()',              'MS-SQL l3liaisonqa1');
pair('connect_pms_prod()',                 'MS-SQL production PMSs');
pair('connect_pms_qa()',                   'MS-SQL l3liaisonqa1');
pair('connect_pms_dev()',                  'MS-SQL OMARES-pms');

pair('connect_opera_prod()',               'Oracle OPERA1@l3operaproddb1vip');
pair('connect_opera_qa()',                 'Oracle OPERA@l3operaqadb1');
pair('connect_opera_dev()',                'Oracle OPERA1@l3operadevdb1vip');
pair('connect_opera()',                    'connect_opera_prod()');
pair('connect_opera()',                    'connect_opera_qa()');
pair('connect_opera()',                    'connect_opera_dev()');


my $edges = {};
open (IN, "find $sourcedir | grep -v svn | xargs grep connect_ |");
while (<IN>) {
   my ($file, $connect) = (/(.*?):.*(connect_.*?)\(/);
   $connect =~ s/\s+//;
   $connect = $connect . "()";
   $file =~ s#$sourcedir/#Omni2/#;
   next unless ($file && $connect);
   next if ($file =~ /DB\.(pm|t)/);
   # print "$file -> $connect\n";
   $edges->{$file}->{$connect} = 1;
}
close IN;
my %all_connections;
foreach my $file (keys %$edges) {
   foreach my $connect (keys %{$edges->{$file}}) {
      $all_connections{$connect} .= "$file\n";
      #print "$file -> $connect\n";
      #pair($file, $connect);
   }
}
foreach my $connect (keys %all_connections) {
   pair($all_connections{$connect}, $connect);
}



open (PNG, ">DBs.png");
print PNG $g->as_png;
close PNG;

sub pair {
   my ($one, $two) = @_;
   $g->add_node($one, %settings);
   $g->add_node($two, %settings);
   $g->add_edge($one => $two);
}
