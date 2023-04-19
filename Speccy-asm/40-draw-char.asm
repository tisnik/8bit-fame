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
; Example #40:
;    Draw one selected character using own drawing routine.

SCREEN_ADR      equ $4000
CHAR_ADR        equ $3c00
ENTRY_POINT     equ $8000

	org ENTRY_POINT

start:
	ld de, CHAR_ADR + 'A'*8  ; adresa masky znaku A
	ld hl, SCREEN_ADR        ; adresa pro zápis
	ld b, 8                  ; počitadlo zapsaných bajtů

loop:
	ld a, (de)               ; načtení jednoho bajtu z masky
	ld (hl), a               ; zápis hodnoty na adresu (HL)
	inc de                   ; posun na další bajt masky
	inc h                    ; posun na definici dalšího obrazového řádku
	djnz loop                ; vnitřní smyčka: blok s osmi zápisy
finish:
	ret                      ; ukončit program

end ENTRY_POINT
