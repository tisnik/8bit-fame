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
