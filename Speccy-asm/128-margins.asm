SCREEN_ADR      equ $4000
ENTRY_POINT     equ $8000

	org ENTRY_POINT

start:
	ld b, 14                 ; x-ová souřadnice
	ld c, 2                  ; y-ová souřadnice
	call calc_sprite_address ; výpočet adresy spritu
	call draw_sprite

	ld b, 14                 ; x-ová souřadnice
	ld c, 5                  ; y-ová souřadnice
	call calc_sprite_address ; výpočet adresy
	call draw_sprite

	ld b, 31                 ; x-ová souřadnice
	ld c, 23                 ; y-ová souřadnice
	call calc_sprite_address ; výpočet adresy
	call draw_sprite

finish:
	jr finish                ; žádný návrat do systému


calc_sprite_address:
	; parametry:
	; B - x-ová souřadnice (ve znacích, ne pixelech)
	; C - y-ová souřadnice (ve znacích, ne pixelech)
	;
	; návratové hodnoty:
	; DE - adresa pro zápis bloku
	;
	; vzor adresy:
	; 0 1 0 Y4 Y3 0 0 0 | Y2 Y1 Y0 X4 X3 X2 X1 X0
	ld  a, c
	and %00000111            ; pouze spodní tři bity y-ové souřadnice (řádky 0..7)
	rrca
	rrca
	rrca                     ; nyní jsou čísla řádků v horních třech bitech
	or  b                    ; připočítat x-ovou souřadnici
	ld  e, a                 ; máme spodní bajt adresy
	                         ; Y2 Y1 Y0 X4 X3 X2 X1 X0

	ld  a, c                 ; y-ová souřadnice
	and %00011000            ; dva bity s indexem "bloku" 0..3 (dolní tři bity už máme zpracovány)
	or  %01000000            ; "posun" do obrazové paměti (na 0x4000)
	ld  d, a                 ; máme horní bajt adresy
	                         ; 0 1 0 Y5 Y4 0 0 0
	ret                      ; návrat z podprogramu


add_e MACRO n                    ; zvýšení hodnoty regitru E
	ld   a, e
	add  a, n
	ld   e, a
endm

draw_sprite:
	ld hl, SPRITE_ADR        ; adresa, od níž začíná maska spritu
	push de
	call draw_8_lines        ; vykreslit prvních 8 řádků spritu

	pop  de
	add_e 32                 ; zvýšit E o hodnotu 32
	push de
	call draw_8_lines        ; vykreslit druhých 8 řádků spritu

	pop  de
	add_e 32                 ; zvýšit E o hodnotu 32
	call draw_8_lines        ; vykreslit třetích 8 řádků spritu

	ret                      ; návrat z podprogramu


	ld b, 8                  ; počitadlo zapsaných řádků


draw_8_lines:
	ld  bc, 8*(256+2)        ; počitadlo zapsaných řádků
loop:
	ldi                      ; přesun jednoho bajtu + úprava stavu počitadla [DE++] = [HL++]; BC--
	ldi                      ; přesun jednoho bajtu + úprava stavu počitadla [DE++] = [HL++]; BC--
	ld  a,(hl)               ; načtení jednoho bajtu z masky
	ld  (de),a               ; zápis hodnoty na adresu (DE)
	inc hl                   ; posun na další bajt masky
	dec e                    ; korekce - posun zpět pod první osmici pixelů
	dec e                    ; korekce
	inc d                    ; posun na definici dalšího obrazového řádku (+256)
	djnz loop                ; vnitřní smyčka: blok s 3x osmi zápisy
	ret                      ; návrat z podprogramu



SPRITE_ADR
	db %00000000, %00000000, %00000000
	db %00000000, %00000000, %00000000
	db %00000001, %11110000, %00010000
	db %00000011, %00111000, %00010000
	db %00000101, %11010111, %00010000
	db %00000101, %11001100, %00010000
	db %00000101, %00110000, %00010000
	db %00000100, %11001000, %00010000
	db %00000111, %00110110, %00010000
	db %00001100, %11111110, %00111000
	db %00011111, %11111000, %00000000
	db %00000000, %00000000, %00110000
	db %00000011, %11111111, %10110000
	db %00000101, %11111110, %11100000
	db %00001110, %11111101, %11000000
	db %00011000, %11111100, %00000000
	db %00011000, %00000000, %00000000
	db %00000001, %11111000, %00000000
	db %00000011, %11111100, %00000000
	db %00000001, %10110000, %00000000
	db %00000010, %00001100, %00000000
	db %00000111, %00001110, %00000000
	db %00011110, %00000111, %10000000
	db %00000000, %00000000, %00000000


end ENTRY_POINT
