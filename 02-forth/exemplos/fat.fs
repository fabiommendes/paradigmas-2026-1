\ Fatorial recursivo
: fat-rec ( n -- n! ) 
    dup 1 > if 
        dup 1- recurse * 
    else 
        drop 1 
    then 
;

\ Fatorial usando loop
: fat-loop ( n -- n! )
    1 swap 1+ 1
    do
        i *
    loop 
;

\ Exemplo de uso: calcular o fatorial de 5
5 fat-loop . cr bye
 