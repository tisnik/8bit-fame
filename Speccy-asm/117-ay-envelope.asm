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
; Example #117:
;    Play tone with non-constant envelope on AY-3-8912 chip.

ENTRY_POINT        equ $8000
AY_SELECT_REGISTER equ $fffd
AY_DATA_REGISTER   equ $bffd



org ENTRY_POINT

start:
	ld      d, 0                   ; výška tónu (spodní bajt)
	ld      e, 251
	call    ay_write               ; zápis hodnoty do AY

	ld      d, 1                   ; výška tónu (horní bajt)
	ld      e, 0
	call    ay_write               ; zápis hodnoty do AY

	ld      d, 8                   ; hlasitost kanálu A
	ld      e, 16                  ; hlasitost ovládat pomocí obálky
	call    ay_write               ; zápis hodnoty do AY

	ld	d, $b                  ; frekvence generátoru obálky (spodní bajt)
	ld      e, 100
	call    ay_write               ; zápis hodnoty do AY

	ld	d, $c                  ; frekvence generátoru obálky (horní bajt)
	ld      e, 0
	call    ay_write               ; zápis hodnoty do AY

	ld	d, $d                  ; nastavení tvaru obálky (bitové pole)
	ld      e, 12
	call    ay_write               ; zápis hodnoty do AY

	ld      d, 7                   ; povolení výstupu z kanálu A
	ld      e, %11111110           ; bitová maska
	call    ay_write               ; zápis hodnoty do AY

loop:
	jr      loop                   ; nechceme návrat do BASICu


ay_write:
	ld      bc, AY_SELECT_REGISTER ; zápis do výběrového registru AY
	out     (c), d                 ; index vybraného registru
	ld      bc,AY_DATA_REGISTER    ; zápis do datového registru AY
	out     (c), e                 ; zapisovaná hodnota
	ret                            ; návrat ze subrutiny


end ENTRY_POINT
