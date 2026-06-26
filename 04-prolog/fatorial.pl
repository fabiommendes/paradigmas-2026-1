:- use_module(library(clpfd)).

n_fatorial(0, 1) :- !.
n_fatorial(N, Fat) :-
  N #> 0,
  Nprev #= N - 1,
  Fat #= N * FatPrev,
  n_fatorial(Nprev, FatPrev).