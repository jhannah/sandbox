%% mutate.erl - mutate a sequence of bases in a single place
%% Author: ndim on Freenode (#erlang)
%% Written with and for deafferret on freenode/#erlang.
%%      http://github.com/ndim/erlang_stuff/blob/master/src/deafferret.erl
%%      http://github.com/jhannah/sandbox/blob/master/erlang/mutate.erl

-module(mutate).

-export([start/0]).
-export([mutate/1, mutate/2]).

-define(DEFAULT_ALPHABET, "ACGT").


%% BUG: If the OrigSequence contains elements not in Alphabet -> wrong result.
%% FIXME: We are using ++ in two places, which mostly is not a good idea.
%% NOTE: We return the results in a very strange kind of "ordering".
%% NOTE: A simple test case of "AAAA" lets you miss permutated characters.


%% Verbose version. Comment out the io:format stuff for a mute version.
mutate([], _Alphabet, _Prefix, Acc) ->
    lists:append(Acc);
mutate([Base|Suffix]=_OrigSequence, Alphabet, Prefix, Acc) ->
    io:format("mutate(~p,~p,~p,~p)~n", [_OrigSequence,Alphabet,Prefix,Acc]),
    NewMutations = [Prefix++[X|Suffix] || X<-Alphabet, X=/=Base],
    io:format("  new: ~p~n", [NewMutations]),
    mutate(Suffix, Alphabet, Prefix++[Base], [NewMutations|Acc]).

mutate(OrigSequence, Alphabet) ->
    mutate(OrigSequence, Alphabet, [], []).

mutate(OrigSequence) ->
    mutate(OrigSequence, ?DEFAULT_ALPHABET).


%% Run example.
example(OrigSequence) ->
    Mutations = mutate(OrigSequence),
    io:format("Mutations of orig sequence ~p for default alphabet ~p:~n"
	      "  ~p~n",
	      [OrigSequence, ?DEFAULT_ALPHABET,
	       Mutations]).

%% Run a few examples.
start() ->
    [ example(X) || X <- ["CATTAG", "AAAA"] ].
