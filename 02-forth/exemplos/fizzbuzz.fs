: fizz-buzz-num ( n -- )
  dup 15 mod 0= if 
    ." fizzbuzz"
    exit
  else
  dup 3 mod 0= if
    ." fizz"
  else
  dup 5 mod 0= if
    ." buzz"
  else
    . 
  then
  then 
  then 
;

 \ : main ( -- )  100 1 do i fizz-buzz-num cr loop ;


: fizz? ( n -- flag )
  3 mod 0= dup if ." fizz" then 
;


: buzz? ( n -- flag )
  5 mod 0= dup if ." buzz" then 
;

: fizzbuzz? ( n -- )
  dup dup fizz? swap buzz? or if drop else . then 
;

: main ( -- )  
  100 1 do i fizzbuzz? cr loop 
;


main bye 