\ Usamos o comando "recurse" para chamar recursivamente uma definição.
: fat-rec ( n -- n! )
   dup 2 < if
       drop 1
   else
       dup 1 - recurse *
   then
;

\ O comando "do ... loop" executa um bloco de código um número específico de
\ vezes. "do" espera dois valores na pilha: o limite superior e o limite inferior.
\ O comando "i" é usado para acessar o contador na iteração atual.
: fat-loop ( n -- n! )
    1 swap 1+ 1
    do
        i *
    loop
;

: dup2 ( a b -- a b a b )
    over
    over
;

\ Crie um comando print-fibs ( n -- ) que lê um valor máximo do topo da pilha
\ e imprime todos os fibonaccis menores que esse valor.
: print-fibs ( n -- )
    0 1 rot
    \ x y max
    begin
        dup2 <
    while
        over . cr
        -rot \ max x y
        dup2 \ max x y (x + y)
        + rot drop \ max y (x + y)
        rot \ y (x + y) max
    repeat

    drop drop drop
;


1000 print-fibs  bye
