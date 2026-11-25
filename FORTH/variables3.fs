( Example compatible with GForth environment on 64bit systems                                                )

( Used in the following article:                                                                             )
( FORTH na počítačích Atari: zásobník návratových adres, práce s proměnnými a poli                           )
( https://www.root.cz/clanky/forth-na-pocitacich-atari-zasobnik-navratovych-adres-prace-s-promennymi-a-poli/ )

: store ! ;
: fetch @ ;
: print ? cr ;
: multiply * ;



variable acceleration
variable mass
variable force

10 mass store
3 acceleration store
mass fetch
acceleration fetch
multiply
force store

force print
