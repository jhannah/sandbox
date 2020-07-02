#!/usr/bin/env perl

# http://www.ram.org/music/primus/misc/family_tree.html
# but as GraphViz2?
 
use strict;
use warnings;
use File::Spec;
use GraphViz2;
use Log::Handler;
 
my($logger) = Log::Handler -> new;
 
$logger->add(
  screen => {
    maxlevel       => 'debug',
    message_layout => '%m',
    minlevel       => 'error',
  }
);
 
my($graph) = GraphViz2 -> new
        (
         edge   => {color => 'grey'},
         global => {directed => 1},
         graph  => {rankdir => 'LR'},
         logger => $logger,
         # node   => {shape => 'oval'},
        );

foreach my $name ('Larry LaLonde', 'Steve Gibb', 'Jeff Becerra', 'Mike Minor') {
  $graph->add_edge(from => 'Blizzard', to => $name);
}
foreach my $name ('Jeff Becerra', 'Larry LaLonde', 'Mike Torrao', 'Mike Sus') {
  $graph->add_edge(from => 'Possessed', to => $name);
}
$graph->add_edge(from => 'Tommy Crank Band', to => 'Les Claypool');

$graph->push_subgraph(
 name  => 'Primate',
 # graph => {label => 'Child'},
 # node  => {color => 'magenta', shape => 'diamond'},
);
#$graph->add_node(name => 'Chadstone', shape => 'hexagon');
#$graph -> add_node(name => 'Waverley', color => 'orange');
$graph->add_edge(from => 'Primate0', to => 'Primate1');
$graph->add_edge(from => 'Primate1', to => 'Primate2');
$graph->pop_subgraph;

foreach my $name ('Les Claypool', 'Todd Huth') {
  $graph->add_edge(from => 'Primate0', to => $name);
}
foreach my $name ('Mark Biederman', 'Les Claypool', 'Larry LaLonde', 'Mike Miner') {
  $graph->add_edge(from => 'Blind Illusion', to => $name);
}
foreach my $name ('Les Claypool', 'Todd Huth', 'Perm Parker') {
  $graph->add_edge(from => 'Primate1', to => $name);
}
foreach my $name ('Les Claypool', 'Todd Huth', 'Peter Libby') {
  $graph->add_edge(from => 'Primate2', to => $name);
}



 
# my($format)      = shift || 'svg';
my($format)      = shift || 'png';
my($output_file) = shift || File::Spec -> catfile("sub.graph.$format");
 
$graph -> run(format => $format, output_file => $output_file);

__DATA__
Blizzard|Larry LaLonde
Blizzard|Steve Gibb (vocals)
        Jeff Becerra (bass)
        Mike Minor


