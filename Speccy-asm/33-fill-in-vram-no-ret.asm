; Example that is used in following article:
;    Vývoj her a dem pro ZX Spectrum: vlastní vykreslovací subrutiny
;    https://www.root.cz/clanky/vyvoj-her-a-dem-pro-zx-spectrum-vlastni-vykreslovaci-subrutiny/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #33:
;    Fill-in screen by ink color, RET optimization.

SCREEN_ADR    equ $4000
ENTRY_POINT   equ $8000

PIXELS        equ 256*192


	org ENTRY_POINT

start:
	ld hl, SCREEN_ADR     ; adresa pro zápis
	ld a, PIXELS/8/256    ; počet opakování bloku s 256 zápisy
	ld b, 0               ; počitadlo vnitřní smyčky

loop:
	ld (hl), 0xff         ; zápis hodnoty na adresu (HL)
	inc hl                ; zvýšení adresy
	djnz loop             ; vnitřní smyčka: blok s 256 zápisy
	dec a                 ; počitadlo vnější smyčky
	jp NZ, loop           ; skok pokud se ještě nedosáhlo nuly
finish:
	jr finish             ; nevrátíme se do systému

end ENTRY_POINT
