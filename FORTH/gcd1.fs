( Example compatible with GForth environment on 64bit systems                            )

( Used in the following article:                                                         )
( FORTH na počítačích Atari: realizace jednoduchých algoritmů                            )
( https://www.root.cz/clanky/forth-na-pocitacich-atari-realizace-jednoduchych-algoritmu/ )

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
