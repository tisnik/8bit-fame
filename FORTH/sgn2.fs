( Example compatible with GForth environment on 64bit systems                            )

( Used in the following article:                                                         )
( FORTH na počítačích Atari: realizace jednoduchých algoritmů                            )
( https://www.root.cz/clanky/forth-na-pocitacich-atari-realizace-jednoduchych-algoritmu/ )

: sgn
  dup
  0< if
     drop
     -1
  else
     0= if
       0
     else
       1
     then
  then
;

100 sgn . cr
-100 sgn . cr
0 sgn . cr
