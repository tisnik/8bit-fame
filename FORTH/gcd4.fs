( Example compatible with GForth environment on 64bit systems                            )

( Used in the following article:                                                         )
( FORTH na počítačích Atari: realizace jednoduchých algoritmů                            )
( https://www.root.cz/clanky/forth-na-pocitacich-atari-realizace-jednoduchych-algoritmu/ )

: tuck ( x1 x2 -- x2 x1 x2 )
  swap over
;

: not0 ( x -- flag )
  0 = 0=
;

: gcd
  begin
    dup not0
  while
    tuck mod
  repeat
  drop
;

100 1 gcd . cr
100 40 gcd . cr
100 25 gcd . cr
100 100 gcd . cr
