: tuck ( x1 x2 -- x2 x1 x2 )
  swap over
;

: gcd
  begin
    .S cr
    dup 0<>
  while
    tuck mod
  repeat
  drop
;

cr
100 40 gcd . cr
