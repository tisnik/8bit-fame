ATTRIBUTE_ADR equ $5800
ENTRY_POINT   equ $8000

	org ENTRY_POINT

start:
	ld hl, ATTRIBUTE_ADR  ; adresa pro zápis
	ld bc, 512            ; počitadlo smyčky

loop:
	ld (hl),l             ; zápis hodnoty na adresu (HL)
	inc hl                ; zvýšení adresy i zapisované hodnoty
	dec bc                ; snížení hodnoty počitadla
	ld a,b
        or c
	jp NZ, loop           ; skok pokud se ještě nedosáhlo nuly
	ret

end ENTRY_POINT
