: gcd
  begin
    dup 0<>
  while
    dup >r mod r> swap
  repeat
  drop
;

100 1 gcd . cr
100 40 gcd . cr
100 25 gcd . cr
100 100 gcd . cr
