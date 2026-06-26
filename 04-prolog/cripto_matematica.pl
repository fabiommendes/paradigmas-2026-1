:- use_module(library(clpfd)).


% Resolucao do problema SEND MORE MONEY
money(Eq) :-
  [  S, E, N, D,
     M, O, R, E,
  M, O, N, E, Y] = Eq,
  Eq ins 0..9,

  all_distinct([S, E, N, D, M, O, R, Y]),

  % Primeiro digito nao nulo
  M #> 0,
  S #> 0,

  % Equacoes para cada componente do puzzle
  Y #= (D + E) mod 10,
  E #= (N + R + X1) mod 10,
  N #= (E + O + X2) mod 10,
  O #= (S + M + X3) mod 10,

  % Lida com o "vai 1"
  ( X1 #= 1, D + E #> 9
  ; X1 #= 0, D + E #=< 9),

  ( X2 #= 1, N + R + X1 #> 9
  ; X2 #= 0, N + R + X1 #=< 9),

  ( X3 #= 1, E + O + X2 #> 9
  ; X3 #= 0, E + O + X2 #=< 9),

  ( M #= 1, S + M + X3 #> 9
  ; M #= 0, S + M + X3 #=< 9).


% Resolucao do problema SEND MORE MONEY
money2(Eq) :-
  [  S, E, N, D,
     M, O, R, E,
  M, O, N, E, Y] = Eq,
  Eq ins 0..9,

  all_distinct([S, E, N, D, M, O, R, Y]),

  % Primeiro digito nao nulo
  M #> 0,
  S #> 0,

  Send  #= 1000 * S + 100 * E + 10 * N + D,
  More  #= 1000 * M + 100 * O + 10 * R + E,
  Money #= 10000 * M + 1000 * O + 100 * N + 10 * E + Y,

  Send + More #= Money.


% Resolucao do problema PARA + AMAPA = GOIAS
goias(Eq) :-
  [  P, A, R, A,
  A, M, A, P, A,
  G, O, I, A, S] = Eq,
  Eq ins 0..9,

  all_distinct([P, A, R, M, G, O, I, S]),

  % Primeiro digito nao nulo
  P #> 0,
  A #> 0,
  G #> 0,

  V1   #=             1000 * P + 100 * A + 10 * R + A,
  V2   #= 10000 * A + 1000 * M + 100 * A + 10 * P + A,
  Res  #= 10000 * G + 1000 * O + 100 * I + 10 * A + S,
  Res  #= V1 + V2.


% Resolucao do problema PARA + AMAPA = GOIAS
cripto_soma(Eq) :-
  [  A1, A2, A3, A4, A5, A6,
     B1, B2, B3, B4, B5, B6,
     C1, C2, C3, C4, C5, C6
  ] = Eq,
  Eq ins 0..9,

  ResA #= 100000 * A1 + 10000 * A2 + 1000 * A3 + 100 * A4 + 10 * A5 + A6,
  ResB #= 100000 * B1 + 10000 * B2 + 1000 * B3 + 100 * B4 + 10 * B5 + B6,
  ResC #= 100000 * C1 + 10000 * C2 + 1000 * C3 + 100 * C4 + 10 * C5 + C6,
  ResC #= ResA + ResB.

money3(Eq) :-
  [S, E, N, D,   M, O, R, E,   M, O, N, E, Y] = Eq,

  cripto_soma([
    0, 0, S, E, N, D,
    0, 0, M, O, R, E,
    0, M, O, N, E, Y
  ]),

  all_distinct([S, E, N, D, M, O, R, Y]),
  S #> 0,
  M #> 0.

grana(Eq) :-
  [M, A, N, D, A,   M, A, I, S,   G, R, A, N, A] = Eq,

  cripto_soma([
    0, M, A, N, D, A,
    0, 0, M, A, I, S ,
    0, G, R, A, N, A
  ]),

  all_distinct([M, A, N, D, I, S, R]),
  M #> 0,
  G #> 0.