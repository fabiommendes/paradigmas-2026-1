\ A sequencia de collatz começa com um número natural (não-nulo)
\ e calcula o próximo com a regra:
\   - se número for par, o próximo número vira n / 2
\   - so número for ímpar, o próximo é dado por 3 * n + 1
\
\ Ex.: 20, 10, 5, 16, 8, 4, 2, 1, ...
: par? ( n -- n bool ) dup 2 mod 0= ;
: stop? ( n -- bool ) dup 1 = ;

: collatz ( n -- ) 
    dup . cr
    
    stop? if
        ." ..."
    else par? if 
        2 / recurse
    else 
        3 * 1 + recurse
    then
    then
; 


1000 collatz cr bye
