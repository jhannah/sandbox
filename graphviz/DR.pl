#!/usr/bin/perl

# http://github.com/jhannah/sandbox / graphviz

use strict;
use GraphViz;

my %normal =  ( fontname => 'Courier', fontsize => 9, shape => 'box', style => 'filled', fillcolor => 'green' );
my %repl =    ( fontname => 'Courier', fontsize => 9, shape => 'box', style => 'filled', fillcolor => 'yellow' );  # replicated
my %service = ( fontname => 'Courier', fontsize => 9 );
my %partial = ( %service, label => 'partial', color => 'blue', fontcolor => 'blue' );

my $g = GraphViz->new(
   # layout => 'fdp',   # force directed spring model
                        # makes everything kind of radiate out from center
                        # instead of cascase down
   rankdir => 1,        # Left to right instead of top to bottom.
);

my $dbs = join "\n", qw( aspect chartofaccounts cms crm hours ideal_idea phpbb rt3 webcal webcal3 );
$g->add_node($dbs, cluster=>"omares-intranet1\n(deprecate me RT8757)", %normal);

my $dbs = join "\n", qw( phoenix omnihub omnimq );
$g->add_node($dbs, cluster=>'dev', %normal);

my $dbs = join "\n", qw( crm phoenix omnihub omnimq );
$g->add_node($dbs, cluster=>'qa', %normal);

$g->add_node('omnihub@l3omnihub1', cluster=>'l3omnihub1', %repl);
$g->add_node('omnimq@l3omnihub1',  cluster=>'l3omnihub1', %normal);
$g->add_node('phoenix@l3omnihub1', cluster=>'l3omnihub1', %repl);

$g->add_node('omnihub@l3omnihub2', cluster=>'l3omnihub2', %repl);
$g->add_node('omnimq@l3omnihub2',  cluster=>'l3omnihub2', %repl);
$g->add_node('phoenix@l3omnihub2', cluster=>'l3omnihub2', %normal);

$g->add_edge('omnimq@l3omnihub1' => 'omnimq@l3omnihub2',        %partial);
$g->add_edge('omnimq@l3omnihub1' => 'omnimq@omares-omnihubdr1', %partial);
$g->add_edge('omnimq@l3omnihub1' => 'omnimq@omares-omnihubdr2', %partial);

# -----------------------
# DR some day?
$g->add_node('omnihub@omares-omnihubdr1', cluster=>'omares-omnihubdr1', %repl);
$g->add_node('omnimq@omares-omnihubdr1',  cluster=>'omares-omnihubdr1', %repl);
$g->add_node('phoenix@omares-omnihubdr1', cluster=>'omares-omnihubdr1', %repl);
$g->add_edge('omnihub@omares-intranet2' => 'omnihub@omares-omnihubdr1');

$g->add_node('omnihub@omares-omnihubdr2', cluster=>'omares-omnihubdr2', %repl);
$g->add_node('omnimq@omares-omnihubdr2',  cluster=>'omares-omnihubdr2', %repl);
$g->add_node('phoenix@omares-omnihubdr2', cluster=>'omares-omnihubdr2', %repl);
$g->add_edge('omnihub@omares-intranet2' => 'omnihub@omares-omnihubdr2');
# -----------------------

$g->add_node('crm', cluster=>'l3omnihub3', %normal);

$g->add_node('omnihub@omares-intranet2', cluster=>'omares-intranet2', %normal);

$g->add_edge('omnihub@omares-intranet2' => 'omnihub@l3omnihub2');
$g->add_edge('omnihub@omares-intranet2' => 'omnihub@l3omnihub1');

my $boxen = "Phoenix";
$g->add_node($boxen, %service);
$g->add_edge($boxen => 'phoenix@l3omnihub2');
$g->add_edge($boxen => 'omnihub@l3omnihub2');

my $boxen = "OmniMQ";
$g->add_node($boxen, %service);
$g->add_edge($boxen => 'omnimq@l3omnihub1');
$g->add_edge($boxen => 'omnihub@l3omnihub1');

$g->add_node('Elmer', %service);
$g->add_edge('Elmer' => 'crm');

$g->add_node('OmniHUB', %service);
$g->add_edge('OmniHUB' => 'omnihub@omares-intranet2');

open (PNG, ">DR.png");
print PNG $g->as_png;
close PNG;


