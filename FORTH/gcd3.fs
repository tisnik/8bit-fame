( Example compatible with GForth environment on 64bit systems                            )

( Used in the following article:                                                         )
( FORTH na počítačích Atari: realizace jednoduchých algoritmů                            )
( https://www.root.cz/clanky/forth-na-pocitacich-atari-realizace-jednoduchych-algoritmu/ )

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
