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



ATTRIBUTE_ADR equ $5800
ENTRY_POINT   equ $8000

	org ENTRY_POINT

start:
	ld hl, ATTRIBUTE_ADR  ; adresa pro zápis
        ld a, 0               ; zapisovaná hodnota
	ld b, 0               ; počitadlo smyčky

loop:
	ld (hl),a             ; zápis hodnoty na adresu (HL)
	inc hl                ; zvýšení adresy
	inc a                 ; zvýšení zapisované hodnoty
	dec b                 ; snížení hodnoty počitadla
	jr NZ, loop           ; skok pokud se ještě nedosáhlo nuly
	ret

end ENTRY_POINT
