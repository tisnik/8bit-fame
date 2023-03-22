; Example that is used in following article:
;    Vývoj pro ZX Spectrum: výpis informací na obrazovku
;    https://www.root.cz/clanky/vyvoj-pro-zx-spectrum-vypis-informaci-na-obrazovku/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;

ENTRY_POINT   equ $8000
ROM_CLS       equ $0DAF

	org ENTRY_POINT

start:
	call ROM_CLS    ; smazání obrazovky a otevření kanálu číslo 2 (screen)

	ld  a, ' '      ; kód prvního zapisovaného znaku
	ld  b, 96+16    ; počitadlo smyčky

loop:
	rst  0x10       ; zavolání rutiny v ROM

	inc a           ; zvýšení zapisované hodnoty (kódu znaku)
	djnz loop       ; kombinace dec b + jp NZ, loop
	                ; snížení hodnoty počitadla
	                ; skok pokud se ještě nedosáhlo nuly
	ret             ; návrat z programu do BASICu

end ENTRY_POINT
