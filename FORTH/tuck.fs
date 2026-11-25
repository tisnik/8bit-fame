( Example compatible with GForth environment on 64bit systems                            )

( Used in the following article:                                                         )
( FORTH na počítačích Atari: realizace jednoduchých algoritmů                            )
( https://www.root.cz/clanky/forth-na-pocitacich-atari-realizace-jednoduchych-algoritmu/ )

: tuck ( x1 x2 -- x2 x1 x2 )
  swap over
;

1 2 3 .s cr
tuck .s cr
