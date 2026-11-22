( Example compatible with GForth environment on 64bit systems                            )

( Used in the following article:                                                         )
( FORTH na počítačích Atari: realizace jednoduchých algoritmů                            )
( https://www.root.cz/clanky/forth-na-pocitacich-atari-realizace-jednoduchych-algoritmu/ )

: pocitadlo
    0
    begin
        dup 10 <
    while
        1 +
        dup . cr
    repeat
    drop
;

pocitadlo
