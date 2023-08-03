SCREEN_ADR             equ $4000
BITMAP_SIZE            equ 32*192
ATTRIBUTE_BLOCK_SIZE   equ 32*64
SCREEN_SIZE            equ BITMAP_SIZE + ATTRIBUTE_BLOCK_SIZE
ENTRY_POINT            equ $8000

	org ENTRY_POINT

start:
	; nejprve přeneseme celý obrázek do obrazové paměti
	ld   hl, LOADING_SCREN   ; adresa zdrojového bloku
	ld   de, SCREEN_ADR      ; adresa cílového bloku
	ld   bc, SCREEN_SIZE     ; velikost přenášených dat
	ldir                     ; provést blokový přenos

finish:
	jr finish                ; žádný návrat do systému


LOADING_SCREN incbin "Alien8.scr"



end ENTRY_POINT
