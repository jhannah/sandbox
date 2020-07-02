#!/usr/bin/env perl

# http://www.ram.org/music/primus/misc/family_tree.html
# but as GraphViz2?

use v5.26; 
use strict;
use warnings;
use File::Spec;
use GraphViz2;
use Log::Handler;
 
my($logger) = Log::Handler->new;
$logger->add(
  screen => {
    maxlevel       => 'debug',
    message_layout => '%m',
    minlevel       => 'error',
  }
);
my($graph) = GraphViz2->new(
  edge   => {color => 'grey'},
  global => {directed => 1},
  graph  => {rankdir => 'LR'},
  logger => $logger,
  # node   => {shape => 'oval'},
);

my $note = <<EOT;
data source: http://www.ram.org/music/primus/misc/family_tree.html
GraphViz2 source code: https://github.com/jhannah/sandbox/blob/master/graphviz/primus.pl
EOT
$graph->add_node(name => $note, shape => 'square');


while (my $line = <DATA>) {
  chomp $line;
  my ($from, $to) = (split m#\|#, $line);
  $graph->add_edge(from => $from, to => $to);
}
 
# my($format)      = shift || 'svg';
my($format)      = shift || 'png';
my($output_file) = shift || File::Spec -> catfile("sub.graph.$format");
 
$graph -> run(format => $format, output_file => $output_file);

# http://www.ram.org/music/primus/misc/family_tree.html
# but in GraphViz2?
__DATA__
Blizzard|Larry LaLonde (guitars)
Blizzard|Steve Gibb (vocals)
Blizzard|Jeff Becerra (bass)
Blizzard|Mike Minor (drums)
Possessed (? 1983 - ? 1988)|Jeff Becerra (vocals/bass)
Possessed (? 1983 - ? 1988)|Larry LaLonde (guitars)
Possessed (? 1983 - ? 1988)|Mike Torrao (guitars)
Possessed (? 1983 - ? 1988)|Mike Sus (drums)
Tommy Crank Band (? - ?)|Les Claypool (bass)
Primate (? 1984 - ?)|Les Claypool (bass, vocals)
Primate (? 1984 - ?)|Todd Huth (guitars)
Blind Illusion (? 1984/85 - ? 1988)|Mark Biederman (vocals/guitars)
Blind Illusion (? 1984/85 - ? 1988)|Les Claypool (bass)
Blind Illusion (? 1984/85 - ? 1988)|Larry LaLonde (guitars)
Blind Illusion (? 1984/85 - ? 1988)|Mike Miner (drums)
Primate (? 1984 - ?)|Primate (#2)
Primate (#2)|Les Claypool (bass, vocals)
Primate (#2)|Todd Huth (guitars)
Primate (#2)|Perm Parker (drums)
Primate (#2)|Primate (#3)
Primate (#3)|Les Claypool (bass, vocals)
Primate (#3)|Todd Huth (guitars)
Primate (#3)|Peter Libby (drums)
Primus (? - ?)|Les Claypool (bass, vocals)
Primus (? - ?)|Robbie Bean (drums)
Primus (? - ?)|Todd Huth (guitars)
Primus (? - ?)|Porch (? 94 - present)
Porch (? 94 - present)|Todd Huth (guitars)
Porch (? 94 - present)|Christopher Frey (bass)
Porch (? 94 - present)|David Ayer (drums)
Primus (? - ?)|Freaky Executives (? 85 - ? 89)
Freaky Executives (? 85 - ? 89)|Jay Lane (drums)
Primus (? - ?)|Primus (Jul 88 - Dec 88)
Primus (Jul 88 - Dec 88)|Les Claypool (bass, vocals)
Primus (Jul 88 - Dec 88)|Todd Huth (guitars)
Primus (Jul 88 - Dec 88)|Jay Lane (drums)
Primus (Jul 88 - Dec 88)|Charlie Hunter Trio/Quartet (? 93 - 6/95)
Charlie Hunter Trio/Quartet (? 93 - 6/95)|Charlie Hunter (guitars)
Charlie Hunter Trio/Quartet (? 93 - 6/95)|Calder Spanier (saxophone)
Charlie Hunter Trio/Quartet (? 93 - 6/95)|Scott Amendola
Charlie Hunter Trio/Quartet (? 93 - 6/95)|Jay Lane (drums)
Charlie Hunter Trio/Quartet (? 93 - 6/95)|David Ellis (saxophone)
Primus (Jul 88 - Dec 88)|Alphabet Soup (? - present)
Alphabet Soup (? - present)|Sam Biggers
Alphabet Soup (? - present)|Wilbur Krebs (bass)
Alphabet Soup (? - present)|C.B. (vocals)
Alphabet Soup (? - present)|Deszon Claiborne (drums)
Alphabet Soup (? - present)|Kenny Brooks (sax)
Alphabet Soup (? - present)|Dred Scott (keys)
Alphabet Soup (? - present)|Jay Lane (drums)
Primus (Jul 88 - Dec 88)|RatDog (1995 - present)
RatDog (1995 - present)|Rob Wasserman (bass)
RatDog (1995 - present)|Bobby Weir (rhythm guitar, vocals)
RatDog (1995 - present)|Jay Lane (drums)
RatDog (1995 - present)|Jeff Chimenti (keyboards)
RatDog (1995 - present)|Kenny Brooks (saxaphone)
RatDog (1995 - present)|Mark Karan (lead guitar)
RatDog (1995 - present)|Dave Ellis (saxophone)
RatDog (1995 - present)|Matthew Kelly (harp)
RatDog (1995 - present)|Dave McNabb
RatDog (1995 - present)|Vince Welnick
RatDog (1995 - present)|Johnnie Johnson
RatDog (1995 - present)|Mookie Segal
Primus (Jul 88 - Dec 88)|Major Lingo (? 87 - ?)
Major Lingo (? 87 - ?)|Sally Stricker (bass, vocals)
Major Lingo (? 87 - ?)|Tony Bruno (slide guitar)
Major Lingo (? 87 - ?)|John Ziegler (guitar, vocals)
Major Lingo (? 87 - ?)|Tim Alexander (drums)
Major Lingo (? 87 - ?)|Major Lingo (#2 ? 87 - ?)
Major Lingo (#2 ? 87 - ?)|Linda Cushma (bass, vocals)
Major Lingo (#2 ? 87 - ?)|Tony Bruno (slide guitar)
Major Lingo (#2 ? 87 - ?)|John Ziegler (guitar, vocals)
Major Lingo (#2 ? 87 - ?)|Tim Alexander (drums)
Primus (Jul 88 - Dec 88)|Primus (? 89 - Jul 96)
Primus (? 89 - Jul 96)|Les Claypool (bass, vocals)
Primus (? 89 - Jul 96)|Larry LaLonde (guitars)
Primus (? 89 - Jul 96)|Tim Alexander (drums)
Primus (? 89 - Jul 96)|Laundry (? 94 - present)
Laundry (? 94 - present)|Tim Alexander (drums)
Laundry (? 94 - present)|Ian Varriale (stick)
Laundry (? 94 - present)|Tom Butler (guitar)
Laundry (? 94 - present)|Toby Hawkins (vocals)
Primus (? 89 - Jul 96)|Sausage (? 94 - present)
Sausage (? 94 - present)|Les Claypool (bass, vocals)
Sausage (? 94 - present)|Todd Huth (guitars, vocals)
Sausage (? 94 - present)|Jay Lane (drums)
Primus (? 89 - Jul 96)|The Limbomaniacs (? 84 - ? 92)
The Limbomaniacs (? 84 - ? 92)|Kelly Smith (vocals)
The Limbomaniacs (? 84 - ? 92)|Mark Haggard (vocals, guitar)
The Limbomaniacs (? 84 - ? 92)|Tony Chaba (bass, vocals)
The Limbomaniacs (? 84 - ? 92)|Brian Mantia (drums)
The Limbomaniacs (? 84 - ? 92)|Pete Scaturro (machines, organ)
The Limbomaniacs (? 84 - ? 92)|Greg Thompson (saxaphone)
Primus (? 89 - Jul 96)|Big City (? 95 - early 87)
Big City (? 95 - early 87)|Pete Scaturro (machines, organ)
Big City (? 95 - early 87)|Joe Gore (guitars)
Big City (? 95 - early 87)|Brian Mantia (drums)
Primus (? 89 - Jul 96)|Caca (May 92 - present)
Caca (May 92 - present)|Ray White (guitar, vocals (ex-Zappa band))
Caca (May 92 - present)|Mark Haggard (guitar)
Caca (May 92 - present)|Tony Chaba (bass)
Caca (May 92 - present)|Brian Mantia (drums)
Caca (May 92 - present)|Larry LaLonde (guitars)
Caca (May 92 - present)|Pete Scaturro (keyboards)
Caca (May 92 - present)|Matt Wheeler (Zappa vocals)
Caca (May 92 - present)|Zoe Ellis (backing vocals)
Caca (May 92 - present)|Brian Kehoe (The Devil on Titties n Beer)
Primus (? 89 - Jul 96)|Praxis (? 92 - ? 95)
Praxis (? 92 - ? 95)|Buckethead (guitar, toys)
Praxis (? 92 - ? 95)|Bill Laswell (composer)
Praxis (? 92 - ? 95)|Bernie Worrell (synthesiser, clavinet, and vital organ)
Praxis (? 92 - ? 95)|AF Next Man Flip (turntable, mixer)
Praxis (? 92 - ? 95)|Brian Mantia (drums)
Praxis (? 92 - ? 95)|Bootsy Collins (space bass, vocals)
Primus (? 89 - Jul 96)|MCM (? 87 - present)
MCM (? 87 - present)|MCM/Miles (vocals)
MCM (? 87 - present)|Brian Mantia (drums)
MCM (? 87 - present)|Hector (guitars)
MCM (? 87 - present)|Gary (guitars)
MCM (? 87 - present)|Danny (bass)
MCM (? 87 - present)|Pause (turntables)
Primus (? 89 - Jul 96)|M.I.R.V. (? 93 - ? 96)
M.I.R.V. (? 93 - ? 96)|Mark Haggard (vocals, guitars)
M.I.R.V. (? 93 - ? 96)|Les Claypool (vocals, bass, drums)
M.I.R.V. (? 93 - ? 96)|Brian Mantia (drums)
M.I.R.V. (? 93 - ? 96)|House (bass, machines)
M.I.R.V. (? 93 - ? 96)|Pete Scaturro (machines, organ)
M.I.R.V. (? 93 - ? 96)|M.I.R.V. (? 96 - ? present)|
M.I.R.V. (? 96 - ? present)|Mark Haggard (vocals, guitars)
M.I.R.V. (? 96 - ? present)|Jeff Gomes (drums)
M.I.R.V. (? 96 - ? present)|Craig McFarland (bass)
M.I.R.V. (? 96 - ? present)|Brian Kehoe (guitar, vocals)
Primus (? 89 - Jul 96)|Primus (Jul 96 - present)
Primus (Jul 96 - present)|Les Claypool (bass, vocals)
Primus (Jul 96 - present)|Larry LaLonde (guitar)
Primus (Jul 96 - present)|Brian Mantia (drums)
Primus (Jul 96 - present)|Les Claypool and the Holy Mackerel (Aug 96 - present)
Les Claypool and the Holy Mackerel (Aug 96 - present)|Les Claypool (bass, vocals, drums, guitars)
Primus (Jul 96 - present)|Colonel Les Claypool's Fearless Flying Frog Brigade (?00 - ?)
Colonel Les Claypool's Fearless Flying Frog Brigade (?00 - ?)|Les Claypool (bass, vocals)
Colonel Les Claypool's Fearless Flying Frog Brigade (?00 - ?)|Todd Huth (guitars, vocals)
Colonel Les Claypool's Fearless Flying Frog Brigade (?00 - ?)|Jay Lane (drums)
Colonel Les Claypool's Fearless Flying Frog Brigade (?00 - ?)|Jeff Chimenti (keyboards)
Colonel Les Claypool's Fearless Flying Frog Brigade (?00 - ?)|Skerik (saxophone)
Colonel Les Claypool's Fearless Flying Frog Brigade (?00 - ?)|Eenor (guitars)
Colonel Les Claypool's Fearless Flying Frog Brigade (?00 - ?)|Colonel Les Claypool's Fearless Flying Frog Brigade (2002? - present)
Colonel Les Claypool's Fearless Flying Frog Brigade (2002? - present)|Les Claypool (bass, vocals)
Colonel Les Claypool's Fearless Flying Frog Brigade (2002? - present)|Mike Dillon (guitars, vocals)
Colonel Les Claypool's Fearless Flying Frog Brigade (2002? - present)|Tim Alexander (drums)
Colonel Les Claypool's Fearless Flying Frog Brigade (2002? - present)|Skerik (saxophone)
Colonel Les Claypool's Fearless Flying Frog Brigade (2002? - present)|Eenor (guitars)
Primus (Jul 96 - present)|Colonel Claypool's Bucket of Bernie Brains (2002? - present)
Colonel Claypool's Bucket of Bernie Brains (2002? - present)|Les Claypool (bass, vocals)
Colonel Claypool's Bucket of Bernie Brains (2002? - present)|Buckethead (guitars, vocals)
Colonel Claypool's Bucket of Bernie Brains (2002? - present)|Brian Mantia (drums)
Colonel Claypool's Bucket of Bernie Brains (2002? - present)|Bernie Worell
