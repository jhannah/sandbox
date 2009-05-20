#!/usr/bin/perl

# http://github.com/jhannah/sandbox / graphviz

use strict;
use GraphViz;

my %normal =  ( fontname => 'Courier', fontsize => 9, shape => 'box', style => 'filled', fillcolor => 'green' );
my %repl =    ( fontname => 'Courier', fontsize => 9, shape => 'box', style => 'filled', fillcolor => 'yellow' );  # replicated
my %dr =      ( fontname => 'Courier', fontsize => 9, shape => 'box', style => 'filled', fillcolor => 'red' );
my %service = ( fontname => 'Courier', fontsize => 9 );

my $g = GraphViz->new(
   layout => 'fdp',
);

my $dbs = join "\n", qw( aspect chartofaccounts cms crm hours ideal_idea phpbb rt3 webcal webcal3 );
$g->add_node($dbs, cluster=>'omares-intranet1', %normal);

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

# DR some day?
$g->add_node('omnihub@dr', cluster=>'dr', %repl);
$g->add_node('omnimq@dr',  cluster=>'dr', %repl);
$g->add_node('phoenix@dr', cluster=>'dr', %repl);
$g->add_edge('omnimq@l3omnihub1' => 'omnimq@dr');
$g->add_edge('phoenix@l3omnihub2' => 'phoenix@dr');
$g->add_edge('omnihub@omares-intranet2' => 'omnihub@dr');

$g->add_node('crm@l3omnihub3', cluster=>'l3omnihub3', %normal);

$g->add_node('crm',      cluster=>'crmqa',      %normal);

$g->add_node('omnihub@omares-intranet2', cluster=>'omares-intranet2', %normal);

$g->add_edge('omnihub@omares-intranet2' => 'omnihub@l3omnihub2');
$g->add_edge('omnihub@omares-intranet2' => 'omnihub@l3omnihub1');

# Actually, we'll probably won't bother replicating these:
# $g->add_edge('omnimq@l3omnihub1' => 'omnimq@l3omnihub2');
# $g->add_edge('phoenix@l3omnihub2' => 'phoenix@l3omnihub1');

my $boxen = "l3phoenixprod1\nl3phoenixprod2\nl3phoenixprod3";
$g->add_node($boxen, %service);
$g->add_edge($boxen => 'phoenix@l3omnihub2');
$g->add_edge($boxen => 'omnihub@l3omnihub2');

my $boxen = "OmniMQ";
$g->add_node($boxen, %service);
$g->add_edge($boxen => 'omnimq@l3omnihub1');
$g->add_edge($boxen => 'omnihub@l3omnihub1');

open (PNG, ">DR.png");
print PNG $g->as_png;
close PNG;


