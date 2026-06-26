
sudoku(Rows) :-
  transpose(Rows, Columns),
  append(Rows, AllValues), % lineariza sudoku em AllValues

  AllValues ins 1..9, % todos números entre 1 e 9
  maplist(all_distinct, Rows), % linhas não tem números repetidos
  maplist(all_distinct, Columns), % colunas não tem números repetidos

  % Garante que os quadrados tenham números distintos
  [As, Bs, Cs,  Ds, Es, Fs,  Gs, Hs, Is] = Rows,
  sudoku_square(As, Bs, Cs),
  sudoku_square(Ds, Es, Fs),
  sudoku_square(Gs, Hs, Is).

sudoku_square([], [], []).
sudoku_square([A, B, C|R1],
              [D, E, F|R2],
              [G, H, I|R3]) :-
  all_distinct([A, B, C, D, E, F, G, H, I]),
  sudoku_square(R1, R2, R3).


example(0, Rows) :-
  Rows = [[_, _, _,  _, _, _,  _, _, _],
          [_, _, _,  _, _, _,  _, _, _],
          [_, _, _,  _, _, _,  _, _, _],

          [_, _, _,  _, _, _,  _, _, _],
          [_, _, _,  _, _, _,  _, _, _],
          [_, _, _,  _, _, _,  _, _, _],

          [_, _, _,  _, _, _,  _, _, _],
          [_, _, _,  _, _, _,  _, _, _],
          [_, _, _,  _, _, _,  _, _, _]].

example(1, Rows) :-
  Rows = [[9, _, _,  5, _, 8,  _, _, 7],
          [_, 8, _,  3, _, _,  9, _, 5],
          [_, 5, 4,  _, _, _,  _, 8, _],

          [_, 7, _,  _, 8, _,  _, 3, 2],
          [1, _, _,  _, _, 4,  _, _, 8],
          [5, _, _,  _, _, _,  _, 6, _],

          [_, _, _,  9, _, 6,  _, _, 1],
          [7, 2, 6,  _, _, 1,  _, 4, _],
          [_, _, 1,  4, 7, _,  _, 5, 6]].


example(3, Rows) :-
  Rows = [[A, _, _,  _, _, E,  _, _, _],
          [_, _, _,  D, _, _,  _, _, _],
          [B, _, C,  _, _, 2,  _, _, _],

          [2, _, F,  _, _, _,  _, _, _],
          [_, H, _,  _, 5, _,  _, _, _],
          [_, _, _,  _, _, _,  _, _, _],

          [_, _, _,  _, _, _,  _, _, _],
          [_, _, _,  _, _, _,  _, _, _],
          [_, _, _,  _, _, _,  _, _, _]].


write_sudoku(Rows) :-
  nl, maplist(print, Rows), nl.

print(X) :- (var(X) -> write("_") ; write(X)), nl.