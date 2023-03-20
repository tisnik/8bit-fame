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
; Example #15:
;    Counted loop with 16-bit counter (optimized variant).



ATTRIBUTE_ADR equ $5800
ENTRY_POINT   equ $8000

	org ENTRY_POINT

start:
	ld hl, ATTRIBUTE_ADR  ; adresa pro zápis
	ld a, 2               ; počet opakování bloku s 256 zápisy
	ld b, 0               ; počitadlo vnitřní smyčky

loop:
	ld (hl),l             ; zápis hodnoty na adresu (HL)
	inc hl                ; zvýšení adresy i zapisované hodnoty
	djnz loop             ; vnitřní smyčka: blok s 256 zápisy
	dec a                 ; počitadlo vnější smyčky
	jp NZ, loop           ; skok pokud se ještě nedosáhlo nuly
	ret

end ENTRY_POINT
