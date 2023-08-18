SCREEN_ADR             equ $4000
BITMAP_SIZE            equ 32*192
ATTRIBUTE_BLOCK_SIZE   equ 32*64
SCREEN_SIZE            equ BITMAP_SIZE ;+ ATTRIBUTE_BLOCK_SIZE
ENTRY_POINT            equ $8000

	org ENTRY_POINT


draw_shifted_sprite MACRO index
	ld hl, SPRITE_SHIFT_0+(index*24*4) ; adresa, od níž začíná maska spritu
	call draw_sprite
endm

shift_sprite MACRO index
	ld hl, SPRITE_ADR+(index*24*4)      ; zdrojová data (originální či dříve posunutý sprite)
	ld de, SPRITE_SHIFT_0+(index*24*4)  ; adresa, od níž začíná maska spritu (nový posunutý sprite)
	ld b,  24                           ; počet opakování kopírovací smyčky
local block                                 ; definice lokálního symbolu (pro opakovanou expanzi makra)
block:
	ld a, [hl]                          ; načíst první bajt spritu na řádku
	srl a                               ; logický posun doprava, zleva se doplní nula, vysunutí nulového bitu do příznaku Carry
	ld [de], a
	inc hl                              ; posun na další bajt ve zdrojovém i cílovém spritu
	inc de

rept 3                                      ; opakovat celý blok 3x
	ld a, [hl]                          ; načíst druhý bajt spritu na řádku
	rra                                 ; posun doprava s nasunutím původního příznaku Carry, vysunutí nulového bitu do příznaku Carry
	ld [de], a
	inc hl                              ; posun na další bajt ve zdrojovém i cílovém spritu
	inc de
endm                                        ; konec opakovaného bloku

	djnz block                          ; a opakovat pro každý řádek spritu
endm

start:
	; nejprve přeneseme celý obrázek do obrazové paměti
	ld   hl, LOADING_SCREN   ; adresa zdrojového bloku
	ld   de, SCREEN_ADR      ; adresa cílového bloku
	ld   bc, SCREEN_SIZE     ; velikost přenášených dat
	ldir                     ; provést blokový přenos

	shift_sprite 0
	shift_sprite 1
	shift_sprite 2
	shift_sprite 3
	shift_sprite 4
	shift_sprite 5
	shift_sprite 6
	shift_sprite 7

	ld b, 18                 ; x-ová souřadnice
	ld c, 0                  ; y-ová souřadnice
	call calc_sprite_address ; výpočet adresy spritu
	draw_shifted_sprite 0

	ld b, 18                 ; x-ová souřadnice
	ld c, 3                  ; y-ová souřadnice
	call calc_sprite_address ; výpočet adresy spritu
	draw_shifted_sprite 1

	ld b, 18                 ; x-ová souřadnice
	ld c, 6                  ; y-ová souřadnice
	call calc_sprite_address ; výpočet adresy
	draw_shifted_sprite 2

	ld b, 18                 ; x-ová souřadnice
	ld c, 9                  ; y-ová souřadnice
	call calc_sprite_address ; výpočet adresy
	draw_shifted_sprite 3

	ld b, 18                 ; x-ová souřadnice
	ld c, 12                 ; y-ová souřadnice
	call calc_sprite_address ; výpočet adresy
	draw_shifted_sprite 4

	ld b, 18                 ; x-ová souřadnice
	ld c, 15                 ; y-ová souřadnice
	call calc_sprite_address ; výpočet adresy
	draw_shifted_sprite 5

	ld b, 18                 ; x-ová souřadnice
	ld c, 18                 ; y-ová souřadnice
	call calc_sprite_address ; výpočet adresy
	draw_shifted_sprite 6

	ld b, 18                 ; x-ová souřadnice
	ld c, 21                 ; y-ová souřadnice
	call calc_sprite_address ; výpočet adresy
	draw_shifted_sprite 7

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
	call draw_8_lines        ; vykreslit prvních 8 řádků spritu + upravit DE pro následující řádek
	call draw_8_lines        ; vykreslit druhých 8 řádků spritu + upravit DE pro následující řádek
	call draw_8_lines        ; vykreslit třetích 8 řádků spritu + upravit DE pro následující řádek
	ret                      ; návrat z podprogramu


draw_8_lines:
	ld  bc, 8*(256+3)        ; počitadlo zapsaných řádků
loop:
	ldi                      ; přesun jednoho bajtu + úprava stavu počitadla [DE++] = [HL++]; BC--
	ldi                      ; přesun jednoho bajtu + úprava stavu počitadla [DE++] = [HL++]; BC--
	ldi                      ; přesun jednoho bajtu + úprava stavu počitadla [DE++] = [HL++]; BC--
	ld  a,(hl)               ; načtení jednoho bajtu z masky
	ld  (de),a               ; zápis hodnoty na adresu (DE)
	inc hl                   ; posun na další bajt masky
	                         ; nyní je vykresleno všech 32 pixelů na řádku
	dec e                    ; korekce (po prvním LDI)
	dec e                    ; korekce (po druhém LDI)
	dec e                    ; korekce (po třetím LDI)
	inc d                    ; posun na definici dalšího obrazového řádku
	                         ; nyní DE ukazuje správně na první bajt na dalším řádku
	djnz loop                ; vnitřní smyčka: blok s 3x osmi zápisy
	ld  a, e                 ; \
	add a, 32                ;  > E += 32
	ld  e, a                 ; /
	ret c                    ; návrat při přenosu (další stránka)
	ld  a, d                 ; \
	sub 8                    ;  > D -= 8
	ld  d, a                 ; /
	ret                      ; návrat z podprogramu



SPRITE_ADR
	db %00000000, %00000000, %00000000, %00000000
	db %00000000, %00000000, %00000000, %00000000
	db %00000001, %11110000, %00010000, %00000000
	db %00000011, %00111000, %00010000, %00000000
	db %00000101, %11010111, %00010000, %00000000
	db %00000101, %11001100, %00010000, %00000000
	db %00000101, %00110000, %00010000, %00000000
	db %00000100, %11001000, %00010000, %00000000
	db %00000111, %00110110, %00010000, %00000000
	db %00001100, %11111110, %00111000, %00000000
	db %00011111, %11111000, %00000000, %00000000
	db %00000000, %00000000, %00110000, %00000000
	db %00000011, %11111111, %10110000, %00000000
	db %00000101, %11111110, %11100000, %00000000
	db %00001110, %11111101, %11000000, %00000000
	db %00011000, %11111100, %00000000, %00000000
	db %00011000, %00000000, %00000000, %00000000
	db %00000001, %11111000, %00000000, %00000000
	db %00000011, %11111100, %00000000, %00000000
	db %00000001, %10110000, %00000000, %00000000
	db %00000010, %00001100, %00000000, %00000000
	db %00000111, %00001110, %00000000, %00000000
	db %00011110, %00000111, %10000000, %00000000
	db %00000000, %00000000, %00000000, %00000000
SPRITE_SHIFT_0:



LOADING_SCREN incbin "Alien8.scr"



end ENTRY_POINT
