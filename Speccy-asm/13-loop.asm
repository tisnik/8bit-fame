; Example that is used in following article:
;    Vývoj pro ZX Spectrum: mikroprocesor Zilog Z80 a smyčky v assembleru
;    https://www.root.cz/clanky/vyvoj-pro-zx-spectrum-mikroprocesor-zilog-z80-a-smycky-v-assembleru/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #13:
;    Counted loop to fill-in attribute memory based on DJNZ instruction and IY register.
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/13-loop.asm



ATTRIBUTE_ADR equ $5800
ENTRY_POINT   equ $8000

	org ENTRY_POINT

start:
	ld iy, ATTRIBUTE_ADR  ; adresa pro zápis
	xor a                 ; zapisovaná hodnota
	ld b, a               ; počitadlo smyčky

loop:
	ld (iy),a             ; zápis hodnoty na adresu (IY)
	inc iy                ; zvýšení adresy
	inc a                 ; zvýšení zapisované hodnoty
	djnz loop             ; kombinace dec b + jp NZ, loop
	                      ; snížení hodnoty počitadla
	                      ; skok pokud se ještě nedosáhlo nuly
	ret

end ENTRY_POINT
