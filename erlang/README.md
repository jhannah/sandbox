Overview
========

I'm working on a project that has a couple million nucleic acids sequences, 
each 18 bases long. Each base is 'A', 'C', 'G', or 'T'. 18 bases in a row 
makes for 69 billion possible sequences. So my actual data (2M) is very 
sparse compared to the potential list (16B).

I want to eliminate duplicates out of my 2M sequences. But by "duplicate" I 
don't mean exact match only. I mean any sequence that is one mutation (a 
single base changes from one letter to another letter) or two mutations away.

Mutation is quite a problem. when you have 18 bases and mutate 2 of them 
that's nearly 3000* possible mutations for each sequence. So to de-dupe my 
2M sequences I actually have to do 6B searches through 2M sequences 
(12 quadrillion comparisons). That's a lot, even with good indexes.

(* Can someone do the exact math for me?)

And this problem is exponential as 18 bases grows to 19 or 20 or 30...

I want a parallel processing solution so it doesn't take so long. Luckily there's 
a 2000 node super-computer I can use. That should help.

The idea is to break my 2M sequences into an arbitrary number of shards.  
To talk through a simpler example, let's pretend my sequences are 4 bases 
long instead of 18.

    AAAA..TTTT is 256 sequences

We split the search space into 4 nodes:

    AAAA..ATTT   64 sequences
    CAAA..CTTT   64 sequences
    GAAA..GTTT   64 sequences
    TAAA..TTTT   64 sequences

Now each node is responsible for doing lookups and remember statistics
regarding a maximum of 64 sequences each. And if our data is very sparse
then that number is far less.



Node methods
============

hmm... how do we bootstrap each node? text file ssh'd to the node?

**mutate(Sequence, NumberOfMutations)**

  Starting with Sequence (e.g. 'AAAA'), iterate every possible Mutant caused by introducting
  NumberOfMutations (e.g. '1' or '2'). For each local Mutant, if Mutant is a known Sequence
  then increment that Sequence's counter. For each remote Mutant, increment_sequence()
  to the node responsible.

**increment_sequence(Sequence)**

  Another node has discovered that one of our Sequences is a Mutant of one of their
  sequences. Increment our counter.

**sequence_is_local(Sequence)**

  Returns true if Sequence is in the local shard. False otherwise.

**node_for_sequence(Sequence)**

  Returns the node responsible for Sequence.

**report()**

  Generate a report of all statistics that have been gathered for all of our Sequences.



Jay's notes
-----------
http://erlang.org/download/getting_started-5.4.pdf
You need matching ~.erlang.cookie files.
http://mad.printf.net/MSCC_matching_instructions/matching.html

