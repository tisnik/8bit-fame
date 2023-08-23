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
; Example #39:
;    Fill-in the 8x8 block of pixels by specified pattern, optimized variant.
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/39-fill-block-optimized.asm



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
