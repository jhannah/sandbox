-module(lib_misc).
-export([perms/1]).

perms([]) -> [[]];
%  perms(L)  -> [[H|T] || H <- L, T <- perms(L--[H])].
perms(L)  -> [[H|T] || H <- L, T <- perms(L--[H])].

