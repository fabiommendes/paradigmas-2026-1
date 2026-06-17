add(X, Y, R) :- R is X + Y.


% sum : List Int -> Int
% sum [] = 0
% sum x::xs = x + sum xs
sum([], R) :- R is 0.
sum([X|Xs], R) :- sum(Xs, Acc), R is Acc + X.

member(X, [X|_]).
member(X, [_|Xs]) :- member(X, Xs).

% repeat : List Int -> Int
% repeat 0 x = []
% repeat n x = x :: repeat (n - 1) x
repeat(0, _, []).
repeat(N, X, R) :-
    N1 is N - 1,
    R = [X | Acc],
    repeat(N1, X, Acc).

% R é o N-ésimo fibonacci
% N = 1, 2, 3, 4, 5, 6, ...
% R = 1, 1, 2, 3, 5, 8, ...
fib(1, 1).
fib(2, 1).
fib(N, R) :-
    % fib(n) = fib(n - 1) + fib(n - 2)
    N > 0,
    N1 is N - 1,
    N2 is N - 2,
    fib(N1, R1),
    fib(N2, R2),
    R is R1 + R2.

%
% Sequência de Fibonaccis
%
fibSeq(0, []).
fibSeq(1, [1]).
fibSeq(2, [1, 1]).
fibSeq(N, R) :-
   N1 is N - 1,
   fibSeq(N1, [ X, Y | Fibs ]),
   Z is X + Y,
   R = [ Z, X, Y | Fibs ].


%
% Collatz
%  N => N / 2 n for par e 3 * N + 1
%  Ex.:
%     21, 64, 32, 16, 8, 4, 2, 1
%
collatz(1, [1]).

collatz(N, R) :-
    N > 1,
    N mod 2 =:= 0,
    N_ is N / 2,
    collatz(N_, Acc),
    R = [N|Acc].

collatz(N, R) :-
    N > 1,
    N mod 2 =:= 1,
    N_ is 3 * N + 1,
    collatz(N_, Acc),
    R = [N|Acc].

par(N) :- 0 =:= N mod 2.
impar(N) :- 0 =\= N mod 2.

