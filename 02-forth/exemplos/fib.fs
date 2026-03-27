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

5 fat-loop . cr
