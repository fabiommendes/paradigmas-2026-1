:- include('paises.pl').
% :- op(1000, xfy, &).

time(X) :- grupo(_, X).
gols(X) :- X > 0.

jogo(brasil, 1, marrocos, 2).
jogo(brasil, 2, haiti, 1).
jogo(escocia, 1, haiti, 0).
jogo(escocia, 1, marrocos, 3).
jogo(brasil, 2, escocia, 1).
jogo(haiti, 1, marrocos, 1).

pontos(Time, jogo(Time, N, _, N), 1).
pontos(Time, jogo(_, N, Time, N), 1).

pontos(Time, jogo(_, N, Time, M), 3) :- M > N.
pontos(Time, jogo(Time, N, _, M), 3) :- N > M.

pontos(Time, jogo(_, N, Time, M), 0) :- M < N.
pontos(Time, jogo(Time, N, _, M), 0) :- N < M.


jogo(A, B) :- jogo(A, _, B, _).
jogo(A, B) :- B @< A, jogo(B, A).