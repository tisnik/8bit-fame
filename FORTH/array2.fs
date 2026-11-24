( Example compatible with GForth environment on 64bit systems                                                )

( Used in the following article:                                                                             )
( FORTH na počítačích Atari: zásobník návratových adres, práce s proměnnými a poli                           )
( https://www.root.cz/clanky/forth-na-pocitacich-atari-zasobnik-navratovych-adres-prace-s-promennymi-a-poli/ )

create a1 100 cells allot

10 a1 5 cells + !
a1 5 cells + @

. cr

