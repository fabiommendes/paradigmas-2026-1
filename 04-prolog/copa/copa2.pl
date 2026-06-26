:- op(100, xfy, vs).
:- op(200, xfy, :).
:- include("paises.pl").
:- include("util.pl").

time(X) :- grupo(_, X).

jogo_fmt(X vs Y, R) :- X @< Y, R = X vs Y.
jogo_fmt(X vs Y, R) :- X @> Y, R = Y vs X.

grupos(c, brasil: 1 vs marrocos: 1).
grupos(c, escocia: 1 vs haiti: 0).
grupos(c, escocia: 0 vs marrocos: 1).
grupos(c, brasil: 3 vs haiti: 0).
grupos(c, haiti: 0 vs marrocos: 3).
grupos(c, brasil: 2 vs escocia: 1).

campeao(X) :- venceu(X, Y), X @< Y, final(X vs Y).
campeao(X) :- venceu(X, Y), X @> Y, final(Y vs X).

finalDup(X vs Y) :-  final(X vs Y).
finalDup(X vs Y) :-  final(Y vs X).

final(X vs Y) :- final_(X vs Y), X @< Y.
final(X vs Y) :- final_(Y vs X), X @< Y.

final_(X vs Y) :-
    semiDup(s1, X vs P1), \+ ganharia(P1, X),
    semiDup(s2, Y vs P2), \+ ganharia(P2, Y).

semi(N, X vs Y) :- semi_(N, X vs Y), X @< Y.
semi(N, X vs Y) :- semi_(N, Y vs X), X @< Y.

semiDup(N, X vs Y) :- semi(N, X vs Y).
semiDup(N, X vs Y) :- semi(N, Y vs X).

semi_(s1, X vs Y) :-
    quartaDup(q1, X vs P1), \+ ganharia(P1, X),
    quartaDup(q2, Y vs P2), \+ ganharia(P2, Y).
semi_(s2, X vs Y) :-
    quartaDup(q3, X vs P1), \+ ganharia(P1, X),
    quartaDup(q4, Y vs P2), \+ ganharia(P2, Y).

quartaDup(N, X vs Y) :- quarta(N, X vs Y).
quartaDup(N, X vs Y) :- quarta(N, Y vs X).

quarta(q1, canada vs mexico).
quarta(q2, coreia vs suica).
quarta(q3, brasil vs paraguai).
quarta(q4, eua vs marrocos).

semis(S) :-
    findall(E, semi(_, E), L),
    maplist(jogo_fmt, L, L2),
    sort(L2, S).

finais(F) :-
    findall(X, final(X), L),
    maplist(jogo_fmt, L, L2),
    sort(L2, F).

% venceu(X, Y) :- time(X), time(Y).
% venceu(brasil, eua).
% venceu(mexico, canada).

ganharia(brasil, eua).
% ganharia(brasil, paraguai).




:- write("\nJOGOS"), nl, forall(final(J), print(J)).
:- write("\nSemis"), nl, forall(semis(S), println(S)).
:- write("\nFinais"), nl, forall(finais(S), println(S)).
% :- forall(campeao(X), print("campeao:", X)).

jogo(A vs B) :-
    grupos(_, A: _ vs B: _) ;
    grupos(_, B: _ vs A: _), A @< B.
jogo(A vs B) :-
    quartas(_, A vs B).

ponto(A, 1) :-
    grupos(_, A: N vs _: N) ;
    grupos(_, _: N vs A: N).
ponto(A, 3) :-
    grupos(_, A: N vs _: M), N > M ;
    grupos(_, _: M vs A: N), N > M.
ponto(A, 0) :-
    grupos(_, A: N vs _: M), N < M ;
    grupos(_, _: M vs A: N), N < M.

pontos(A, Pts) :- findall(Pt, ponto(A, Pt), L), sum_list(L, Pts).

tabela(Grupo, Time, [Pts, Sg, Gf]) :-
    grupo(Grupo, Time), pontos(Time, Pts),
    gols_feitos(Time, Gf),
    saldo_de_gols(Time, Sg).

gols_feitos(A, Gols) :-
    findall(Gol, grupos(_, A: Gol vs _:_), L1),
    findall(Gol, grupos(_, _:_ vs A: Gol), L2),
    sum_list(L1, G1),
    sum_list(L2, G2),
    Gols is G1 + G2.

gols_tomados(A, Gols) :-
    findall(Gol, grupos(_, A: _ vs _: Gol), L1),
    findall(Gol, grupos(_, _: Gol vs A: _), L2),
    sum_list(L1, G1),
    sum_list(L2, G2),
    Gols is G1 + G2.

saldo_de_gols(A, Gols) :-
    gols_tomados(A, Gt),
    gols_feitos(A, Gf),
    Gols is Gf - Gt.

tabela_ordenada(Grupo, T) :-
    findall([A, B, C, Time], tabela(Grupo, Time, [A, B, C]), L),
    sort(0, @>, L, Ls),
    maplist(rot4, Ls, T).

primeiro(G, Time) :- tabela_ordenada(G, [[Time | _] | _]).
segundo(G, Time) :- tabela_ordenada(G, [_, [Time | _] | _]).


quartas(q1, A vs B) :- primeiro(a, A), segundo(c, B).
quartas(q2, A vs B) :- primeiro(b, A), segundo(d, B).
quartas(q3, A vs B) :- primeiro(c, A), segundo(a, B).
quartas(q3, A vs B) :- primeiro(d, A), segundo(d, B).

semis(s1, A vs B) :- venceu(q1, A), venceu(q2, B).
semis(s2, A vs B) :- venceu(q3, A), venceu(q4, B).

final(f1, A vs B) :- venceu(s1, A), venceu(s2, B).



rot4([A, B, C, D], [D, A, B, C]).

% :- grupos(c, {brasil=1, marrocos=1}).
% :- forall(jogo(brasil vs Outro), (write(brasil vs Outro), nl)).
% :- forall(jogo(brasil vs Outro), (write(Outro), nl)).
% :- forall(ponto(brasil, Pt), (write(Pt), nl)).
% :- forall(pontos(marrocos, Pts), (write(Pts), nl)).

% :- forall(tabela(c, Time, Pts), (write(Time), write(": "), write(Pts), nl)).
% :- forall(gols_feitos(brasil, R), (write(R), nl)).
% :- forall(saldo_de_gols(brasil, R), (write(R), nl)).
% :- forall(tabela_ordenada(c, R), (write(R), nl)).
% :- forall(primeiro(c, R), (write(R), nl)).
% :- forall(segundo(c, R), (write(R), nl)).

%:- forall(ponto({brasil, Pt), (write(Pt), nl)).