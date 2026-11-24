( Example compatible with GForth environment on 64bit systems                                                )

( Used in the following article:                                                                             )
( FORTH na počítačích Atari: zásobník návratových adres, práce s proměnnými a poli                           )
( https://www.root.cz/clanky/forth-na-pocitacich-atari-zasobnik-navratovych-adres-prace-s-promennymi-a-poli/ )

3 constant A
4 constant B

: hypot dup * swap dup * + ;

A B hypot . cr

