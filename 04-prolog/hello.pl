:- discontiguous homem/1.
:- discontiguous mulher/1.
:- discontiguous progenitor/1.

% Introduzimos os personagens (Simpsons)
homem(homer).
homem(bart).
homem(abe).
mulher(marge).
mulher(lisa).
mulher(maggie).
mulher(selma).
mulher(patty).
mulher(jackie).

% Arvore genealógica
progenitor(abe, homer).
progenitor(homer, bart).
progenitor(marge, bart).
progenitor(homer, lisa).
progenitor(marge, lisa).
progenitor(homer, maggie).
progenitor(marge, maggie).
progenitor(jackie, marge).
progenitor(jackie, patty).
progenitor(jackie, selma).

% Game of Thrones (personagens)
mulher(cersei).
mulher(myrcella).
homem(robert).
homem(jamie).
homem(tyrion).
homem(tywin).
homem(tywin).
homem(joffrey).
homem(tomem).

% Game of Thrones (genealogia)
progenitor(tywin, cersei).
progenitor(tywin, jamie).
progenitor(tywin, tyrion).
progenitor(cersei, joffrey).
progenitor(jamie, joffrey).
progenitor(cersei, tomem).
progenitor(jamie, tomem).
progenitor(cersei, myrcella).
progenitor(jamie, myrcella).

% Geramos relações adicionais
mãe(X, Y) :- progenitor(X, Y), mulher(X).
pai(X, Y) :- progenitor(X, Y), homem(X).
filha(X, Y) :- progenitor(Y, X), mulher(X).
filho(X, Y) :- progenitor(Y, X), homem(X).

% Geração avô/avó
avô(X, Y) :- pai(X, ProgenitorDeY), progenitor(ProgenitorDeY, Y).
avó(X, Y) :- mãe(X, ProgenitorDeY), progenitor(ProgenitorDeY, Y).

% Irmão/irmã
irmão(X, Y) :- progenitor(P, X), progenitor(P, Y), homem(X), \+ (X = Y).
irmã(X, Y) :- progenitor(P, X), progenitor(P, Y), mulher(X), \+ (X = Y).

% Tio/tia
tio(X, Y) :- irmão(X, P), pai(P, Y);
             irmão(X, P), mãe(P, Y).

tia(X, Y) :- irmã(X, P), pai(P, Y);
             irmã(X, P), mãe(P, Y).