\ consome a pilha até encontrar um zero e deixa
\ o resultado da soma no topo
: soma ( 0 a b ... n -- [ a + b + ... + n ] )
    0
    begin
      swap dup 0 <>
    while
      +
    repeat
    drop
;

\ consome a pilha até encontrar um zero e deixa
\ o resultado da media no topo da pilha de floats
: media ( 0 a b ... n -- ) ( [a + b + ... + n] / N )
    0 0
    begin
      rot dup 0 <>
    while
      + \ ... contador acc
      swap 1+
      swap
    repeat
    drop

    s>f s>f
    F/
;

0 1 2 3 4 soma
. cr
bye