:- include(tinder_db).

% Vamos começar definindo a relação de match, que é quando duas pessoas gostam 
% uma da outra.
match(X, Y).

:- write("Lista de matches:"), nl.
:- forall(match(X, Y), (write([X, Y]), nl)).

% Note que esta relação inclui os matches duplicados, ou seja, tanto [X, Y] 
% quanto [Y, X] aparecerão. Podemos coletar a lista com todos os pares com
% findall/3 (% https://www.swi-prolog.org/pldoc/man?predicate=findall/3):
all_pairs(L) :- findall([X, Y], match(X, Y), L).

:- nl, write("Lista de matches (com duplicados):"), nl.
:- forall(all_pairs(L), (write(L), nl)).


% Para eliminar os matches duplicados, vamos definir uma relação auxiliar
% exclude(X, L, R) que exclui todos os X de uma lista L, resultando em R.
exclude(X, L, R).

:- nl, write("Testando exclude:"), nl.
:- forall(exclude(1, [1, 2, 1, 3], R), (write("R: "), write(R), nl)).

% Agora podemos definir a relação unique_matches(L, R) que coleta os matches 
% únicos em L e salvam em R. Coloque apenas os pares em ordem alfabética, ou seja, 
% [joao, maria] mas não [maria, joao].
unique_matches(L, Normalized).

:- nl, write("Lista de matches únicos:"), nl.
:- forall((all_pairs(L), unique_matches(L, R)), (write(R), nl)).
    

% Depois fazemos a relação best-matches(L, R). Ela é similar a unique-matches,
% mas remove todos os matches que envolvem pessoas que já estiverem em outro match. 
% Por exemplo, se [joao, maria] apareceram em L, então remove todos os 
% matches que envolvem joao ou maria, como [joao, jose] ou [maria, gil].
%
% Idealmente, inclua pares únicos e listados de forma ordenada.
best_matches(L, Best).

:- nl, write("Lista de matches únicos:"), nl.
:- forall((all_pairs(All), unique_matches(All, Unique), best_matches(Unique, Best)), (write(Best), nl)).

