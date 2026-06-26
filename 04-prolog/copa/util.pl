print() :- nl.
print([]) :- nl.
print([X | Xs]) :- write(X), write(" "), print(Xs).
print(X) :- write(X), nl.
print(X, Y) :- write(X), write(" "), print(Y).
print(X, Y, Z) :- write(X), write(" "), print(Y, Z).
print(X, Y, Z, W) :- write(X), write(" "), print(Y, Z, W).


println([]) :- nl.
println([X | Xs]) :- write(X), nl, println(Xs).