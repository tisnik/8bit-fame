( Example compatible with GForth environment on 64bit systems                                                )

( Used in the following article:                                                                             )
( FORTH na počítačích Atari: zásobník návratových adres, práce s proměnnými a poli                           )
( https://www.root.cz/clanky/forth-na-pocitacich-atari-zasobnik-navratovych-adres-prace-s-promennymi-a-poli/ )

: factorial
    1
    swap
    1 +
    1
    do
        i *
    loop
;

: test-factorial
    21
    1
    do
        i dup . 
        factorial . cr
    loop
;

test-factorial
