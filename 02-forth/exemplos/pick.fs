\ Reimplementa a função pick
: pick' ( i -- n )
  dup 0= if
    drop dup exit
  then

  1- swap >r recurse r> swap
;

\ Reduz a pilha ao seu valor máximo
: abs-max
  depth 1 = if
    exit
  then

  max recurse
;

\ Soma +1 a todos os elementos da pilha
: bump
  depth 0= if exit then

  1 + >r recurse r>
;