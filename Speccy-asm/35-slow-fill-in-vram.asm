SCREEN_ADR    equ $4000
ENTRY_POINT   equ $8000

PIXELS        equ 256*192


	org ENTRY_POINT

start:
	ld hl, SCREEN_ADR     ; adresa pro zápis
	ld c, PIXELS/8/256    ; počet opakování bloku s 256 zápisy
	ld b, 0               ; počitadlo vnitřní smyčky

loop:

	xor a                 ; počitadlo zpožďovací smyčky
delay:
	dec a                 ; snížení hodnoty počitadla (v první iteraci 256->255)
	jr  NZ, delay         ; opakovat, dokud není dosaženo nuly
	
	ld (hl), 0xff         ; zápis hodnoty na adresu (HL)
	inc hl                ; zvýšení adresy
	djnz loop             ; vnitřní smyčka: blok s 256 zápisy
	dec c                 ; počitadlo vnější smyčky
	jp NZ, loop           ; skok pokud se ještě nedosáhlo nuly
	ret                   ; návrat do systému

end ENTRY_POINT
