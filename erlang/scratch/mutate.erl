-module(mutate).
-export([mutate/1]).
-export([dictionary/0]).

% mutate:mutate($C).
% Hand in character 'C' and we return to you "AGT" (actually a list of integers)
% Erlang you crazy fox.
mutate(Base) -> [ X || X <- dictionary(), X =/= Base].

% Our dictionary will change if we want to do amino acide strings. So it's split out 
% down here.
dictionary() -> "ACGT".


