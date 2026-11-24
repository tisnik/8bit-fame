( Example compatible with GForth environment on 64bit systems                                                )

( Used in the following article:                                                                             )
( FORTH na počítačích Atari: zásobník návratových adres, práce s proměnnými a poli                           )
( https://www.root.cz/clanky/forth-na-pocitacich-atari-zasobnik-navratovych-adres-prace-s-promennymi-a-poli/ )

create pole 10 , 20 , 30 , 35 , 100 ,

pole @ . cr
pole . cr

cr

pole 1 + @ . cr
pole 2 + @ . cr
pole 4 + @ . cr
pole 8 + @ . cr


