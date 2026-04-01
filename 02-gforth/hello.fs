: say-hello ( -- )
  ." Hello, World!" cr
;

: dbg ." TOS = " dup . cr ;

: rot13
  key dup emit ."  -> " 13 + dbg 97 - 26 mod 97 + emit cr
  recurse
;

rot13