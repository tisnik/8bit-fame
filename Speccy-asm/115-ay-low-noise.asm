; Example that is used in following article:
;    Podrobnější popis možností zvukového čipu řady AY-3–8910 na ZX Spectru 128k
;    https://www.root.cz/clanky/podrobnejsi-popis-moznosti-zvukoveho-cipu-rady-ay-3-8910-na-zx-spectru-128k/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #115:
;    Play low frequency noise signal AY-3-8912 chip.

ENTRY_POINT        equ $8000
AY_SELECT_REGISTER equ $fffd
AY_DATA_REGISTER   equ $bffd



org ENTRY_POINT

start:
	ld      a, 5                   ; výška šumu
      	ld      bc, AY_SELECT_REGISTER
	out     (c), a
	ld      a, 63
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
	ld      a, %11110111           ; bitová maska
	ld      bc, AY_DATA_REGISTER
	out     (c), a                 ; zápis hodnoty do AY

loop:
	jr loop                        ; nechceme návrat do BASICu


end ENTRY_POINT
