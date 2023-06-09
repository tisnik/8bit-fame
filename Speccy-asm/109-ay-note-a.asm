ENTRY_POINT        equ $8000
AY_SELECT_REGISTER equ $fffd
AY_DATA_REGISTER   equ $bffd



org ENTRY_POINT

start:
	ld      a, 0                   ; výška tónu (spodní bajt)
      	ld      bc, AY_SELECT_REGISTER
	out     (c), a
	ld      a, 242
	ld      bc, AY_DATA_REGISTER
	out     (c), a                 ; zápis hodnoty do AY

	ld      a, 1                   ; výška tónu (horní bajt)
      	ld      bc, AY_SELECT_REGISTER
	out     (c), a
	ld      a, 7
	ld      bc, AY_DATA_REGISTER
	out     (c), a                 ; zápis hodnoty do AY

	ld      a, 8                   ; hlasitost kanálu A
      	ld      bc, AY_SELECT_REGISTER
	out     (c), a
	ld      a, 15                  ; maximální hlasitost
	ld      bc, AY_DATA_REGISTER
	out     (c), a                 ; zápis hodnoty do AY

	ld      a, 7                   ; povolení výstupu z kanálu A
      	ld      bc, AY_SELECT_REGISTER
	out     (c), a
	ld      a, %11111110           ; bitová maska
	ld      bc, AY_DATA_REGISTER
	out     (c), a                 ; zápis hodnoty do AY

loop:
	jr loop                        ; nechceme návrat do BASICu


end ENTRY_POINT
