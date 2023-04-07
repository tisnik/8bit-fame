; Example that is used in following article:
;    Vývoj pro ZX Spectrum: výpis informací na obrazovku
;    https://www.root.cz/clanky/vyvoj-pro-zx-spectrum-vypis-informaci-na-obrazovku/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #30:
;    Print string using subroutine stored in ROM

ENTRY_POINT      equ $8000
ROM_OPEN_CHANNEL equ $1601
ROM_PRINT        equ $203C

INK              equ $10
PAPER            equ $11
FLASH            equ $12
BRIGHT           equ $13
INVERSE          equ $14

BLACK_COLOR      equ %000
BLUE_COLOR       equ %001
RED_COLOR        equ %010
MAGENTA_COLOR    equ %011
GREEN_COLOR      equ %100
CYAN_COLOR       equ %101
YELLOW_COLOR     equ %110
WHITE_COLOR      equ %111


	org ENTRY_POINT

start:
	ld   A,2              ; číslo kanálu
	call ROM_OPEN_CHANNEL ; otevření kanálu číslo 2 (screen)

	ld   DE, TEXT         ; adresa prvního znaku v řetězci
	ld   BC, TEXT_LENGTH  ; délka textu
	call ROM_PRINT        ; volání subrutiny v ROM
	ret                   ; ukončit program

; řetězec
TEXT:	db PAPER, RED_COLOR, "Hello", INK, WHITE_COLOR, "Speccy", FLASH, 1, "!"

TEXT_LENGTH: equ $ - TEXT

end ENTRY_POINT
