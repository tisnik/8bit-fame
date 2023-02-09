ATTRIBUTE_ADR equ $5800
ENTRY_POINT   equ $8000

	org ENTRY_POINT

start:
	ld hl, ATTRIBUTE_ADR  ; adresa pro zápis
	ld b, l               ; zapisovaná hodnota + počitadlo smyčky

loop:
	ld (hl),l             ; zápis hodnoty na adresu (HL)
	inc hl                ; zvýšení adresy i zapisované hodnoty
	djnz loop             ; kombinace dec b + jp NZ, loop
	                      ; snížení hodnoty počitadla
	                      ; skok pokud se ještě nedosáhlo nuly
	ret

end ENTRY_POINT
