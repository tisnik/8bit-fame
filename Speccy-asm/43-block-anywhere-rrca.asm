SCREEN_ADR      equ $4000
ENTRY_POINT     equ $8000

PATTERN         equ $ff


	org ENTRY_POINT

start:

	ld b, 0                 ; x-ová souřadnice
	ld c, 0                 ; y-ová souřadnice
	call calc_block_address ; výpočet adresy
	ld a, PATTERN
	call fill_block         ; vykreslit blok

	ld b, 15                ; x-ová souřadnice
	ld c, 12                ; y-ová souřadnice
	call calc_block_address ; výpočet adresy
	ld a, PATTERN
	call fill_block         ; vykreslit blok

	ld b, 2                 ; x-ová souřadnice
	ld c, 2                 ; y-ová souřadnice
	call calc_block_address ; výpočet adresy
	ld a, PATTERN
	call fill_block         ; vykreslit blok

	ld b, 31                ; x-ová souřadnice
	ld c, 23                ; y-ová souřadnice
	call calc_block_address ; výpočet adresy
	ld a, PATTERN
	call fill_block         ; vykreslit blok

finish:
	jr finish               ; žádný návrat do systému


calc_block_address:
        ; parametry:
	; B - x-ová souřadnice (ve znacích, ne pixelech)
	; C - y-ová souřadnice (ve znacích, ne pixelech)
	;
	; návratové hodnoty:
	; HL - adresa pro zápis bloku
	;
	; vzor adresy:
	; 0 1 0 Y4 Y3 0 0 0 | Y2 Y1 Y0 X4 X3 X2 X1 X0
	ld  a, c
	and %00000111         ; pouze spodní tři bity y-ové souřadnice (řádky 0..7)
	rrca
	rrca
	rrca                  ; nyní jsou čísla řádků v horních třech bitech
	or  b                 ; připočítat x-ovou souřadnici
	ld  l, a              ; máme spodní bajt adresy
	                      ; Y2 Y1 Y0 X4 X3 X2 X1 X0

	ld  a, c              ; y-ová souřadnice
	and %00011000         ; dva bity s indexem "bloku" 0..3 (dolní tři bity už máme zpracovány)
	or  %01000000         ; "posun" do obrazové paměti (na 0x4000)
	ld  h, a              ; máme horní bajt adresy
	                      ; 0 1 0 Y5 Y4 0 0 0
	ret                   ; návrat z podprogramu


fill_block:
        ; parametry:
        ; A - pattern
        ; HL - adresa vykreslení bloku
	ld b, 8               ; počitadlo zapsaných bajtů
loop:
	ld (hl), PATTERN      ; zápis hodnoty na adresu (HL)
	inc h                 ; posun na definici dalšího obrazového řádku
	djnz loop             ; vnitřní smyčka: blok s osmi zápisy
	ret                   ; návrat z podprogramu


end ENTRY_POINT
