:- use_module(library(clpfd)).

n_queens(N, Qs) :-
  length(Qs, N),
  Qs ins 1 .. N,
  all_distinct(Qs), % rainhas não compartilham a mesma linha
  distinct_diagonals(Qs).

distinct_diagonals(Qs) :-
  distinct_diagonals(Qs, 1, 0, Diag1),
  distinct_diagonals(Qs, -1, 0, Diag2),
  all_distinct(Diag1),
  all_distinct(Diag2).

% Salva em R = [Q1 + Mul * 0, Q2 + Mul * 1, ...]
distinct_diagonals([], _, _, []).
distinct_diagonals([Q|Qs], Mul, Idx, [R|Rs]) :-
  R #= Q + Mul * Idx,
  IdxNext #= Idx + 1,
  distinct_diagonals(Qs, Mul, IdxNext, Rs).


write_queens(Qs) :-
  length(Qs, N),
  nl,
  forall(between(1, N, Line), (
    forall(between(1, N, Idx), (
      nth1(Idx, Qs, Q),
      (Q = Line ->   % if/else do prolog
        write(" Q ") ;
        write(" . ")
      )
    )),
    nl
  )).
