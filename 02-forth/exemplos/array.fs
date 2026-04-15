\ Reserva um buffer com 999 elementos
variable numbers 999 cells allot

\ Inicializa o tamanho do array como zero
variable numbers.size
0 numbers.size !

\ Salva n na posição especificada no array numbers
: set ( n i -- )
  dup -rot
  numbers swap cells + !

  \ Testa se precisa redimensionar o array
  dup numbers.size @ >= if
    1+ numbers.size !
  else
      drop
  then
;

\ Pega o número na posicao i da array
: get ( i -- n )
  numbers swap cells + @
;

\ Push
: push ( n -- )
  numbers.size @ set
;

\ Pop
: pop ( -- n )
  numbers.size @ 1-
  dup
  get
  numbers.size !
;

: show-numbers ( -- )
  ." [ "
  numbers.size @ 0 do
    i 0 <> if ." , " then
    i get .
  loop
  ." ] "
;

show-numbers cr bye