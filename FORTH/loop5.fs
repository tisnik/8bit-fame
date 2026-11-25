( Example compatible with GForth environment on 64bit systems                                                )

( Used in the following article:                                                                             )
( FORTH na počítačích Atari: zásobník návratových adres, práce s proměnnými a poli                           )
( https://www.root.cz/clanky/forth-na-pocitacich-atari-zasobnik-navratovych-adres-prace-s-promennymi-a-poli/ )

0  constant min_counter
10 constant max_counter
1  constant increment

: pocitadlo
    min_counter
    begin
        dup max_counter <
    while
        increment +
        dup . cr
    repeat
    drop
;

pocitadlo
