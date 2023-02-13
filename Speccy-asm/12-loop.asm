ATTRIBUTE_ADR equ $5800
ENTRY_POINT   equ $8000

	org ENTRY_POINT

start:
	ld ix, ATTRIBUTE_ADR  ; adresa pro zápis
	xor a                 ; zapisovaná hodnota
	ld b, a               ; počitadlo smyčky

loop:
	ld (ix),a             ; zápis hodnoty na adresu (IX)
	inc ix                ; zvýšení adresy
	inc a                 ; zvýšení zapisované hodnoty
	djnz loop             ; kombinace dec b + jp NZ, loop
	                      ; snížení hodnoty počitadla
	                      ; skok pokud se ještě nedosáhlo nuly
	ret

end ENTRY_POINT
