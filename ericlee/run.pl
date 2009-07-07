#!/usr/bin/perl -w
#Usage: get_seq.pl <sequences file> <sequences tag list>

use warnings;
use strict;

use Bio::SeqIO;
use Bio::Seq;

my $seq = $ARGV[0];
my $list = $ARGV[1];
my @list;
my @raw_seq;
open my $LIST, '<', "$list";
while (<$LIST>)
{
  chomp;
  push @list, $_;
}
close $LIST;
my $seqIOobj = Bio::SeqIO->new(-file=>"$seq");
while ((my $seqobj = $seqIOobj->next_seq()))
{
  my $id = $seqobj->primary_id(); 
  my $raw_seq = $seqobj->seq();
  foreach my $item (@list)
  {
    if ($item =~ /\Q$id\E/i)
    {
      push @raw_seq, ">$id\n$raw_seq\n";
      last;
    }
  }
}
foreach my $foobar (@raw_seq)
{
  print "$foobar";
}

