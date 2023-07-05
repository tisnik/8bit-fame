; Example that is used in following article:
;    Zvuky a hudba na ZX Spectru: zvukové čipy řady AY-3–8910
;    https://www.root.cz/clanky/zvuky-a-hudba-na-zx-spectru-zvukove-cipy-rady-ay-3-8910/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;

ENTRY_POINT        equ $8000
AY_SELECT_REGISTER equ $fffd
AY_DATA_REGISTER   equ $bffd



org ENTRY_POINT

start:
	ld      a, 0                   ; výška tónu (spodní bajt)
      	ld      bc, AY_SELECT_REGISTER
	out     (c), a
	ld      a, 251
	ld      bc, AY_DATA_REGISTER
	out     (c), a                 ; zápis hodnoty do AY

	ld      a, 1                   ; výška tónu (horní bajt)
      	ld      bc, AY_SELECT_REGISTER
	out     (c), a
	ld      a, 0
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
