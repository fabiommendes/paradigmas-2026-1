\ Comando for (do)
\ <final> <inicio> do <bloco> loop
\ valor final do contador é não inclusivo
: count-10-a
  11 1 do
    i . cr
  loop
;

\ while (begin/while/repeat)
\ begin <condicao> while <bloco> repeat
: count-10-b
  1
  begin
    dup 10 <=
  while
    dup . cr
    1+
  repeat
;

\ do-while (begin/until)
\ begin <bloco> <condicao> until
: count-10-c
  1
  begin
    dup . cr
    1+
    dup 10 > \ continua iterando até a condição ser verdadeira
  until
;

\ Loop usando recursão
: iterate-to-10 ( n -- n )
  dup 10 <= if
    dup . cr
    1 +
    recurse
  else
    drop
  then
;

: count-10-d
  1 iterate-to-10
;

count-10-d bye

