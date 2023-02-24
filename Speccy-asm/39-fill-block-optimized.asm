SCREEN_ADR      equ $4000
ENTRY_POINT     equ $8000

PIXELS          equ 256*192

PATTERN         equ %10101010


	org ENTRY_POINT

start:
	ld hl, SCREEN_ADR     ; adresa pro zápis
	ld b, 8               ; počitadlo zapsaných bajtů

loop:
	ld (hl), PATTERN      ; zápis hodnoty na adresu (HL)
	inc h                 ; posun na definici dalšího obrazového řádku
	djnz loop             ; vnitřní smyčka: blok s osmi zápisy
finish:
	ret                   ; ukončit program

end ENTRY_POINT
