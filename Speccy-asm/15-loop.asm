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
