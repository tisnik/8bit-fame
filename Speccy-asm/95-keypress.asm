; Example that is used in following article:
;    Práce s klávesnicí na ZX Spectru
;    https://www.root.cz/clanky/prace-s-klavesnici-na-zx-spectru/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame

ATTRIBUTE_ADR equ $5800
ENTRY_POINT   equ $8000

BLINK_BIT     equ %10000000
INTENSITY_BIT equ %01000000
BLACK_COLOR   equ %000
BLUE_COLOR    equ %001
RED_COLOR     equ %010
MAGENTA_COLOR equ %011
GREEN_COLOR   equ %100
CYAN_COLOR    equ %101
YELLOW_COLOR  equ %110
WHITE_COLOR   equ %111

KB_ROW_0_PORT equ $fefe

SHIFT_KEY_MASK equ %00000001


	org ENTRY_POINT

start:
	ld  bc, KB_ROW_0_PORT          ; adresa portu, ze kterého budeme číst údaje
	in  a, (c)                     ; vlastní čtení z portu (5 bitů)
	and SHIFT_KEY_MASK             ; test, zda je stisknuta klávesa SHIFT
	jr  z, shift_pressed           ; pokud je stlačena, skok
	ld  a, WHITE_COLOR << 3        ; "neviditelný" atribut
	ld  (ATTRIBUTE_ADR+32*3+2), a  ; zápis atributu do atributové paměti
	jp  start                      ; opětovný test stisku klávesy
shift_pressed:
	ld  a, INTENSITY_BIT | (RED_COLOR << 3)
	ld  (ATTRIBUTE_ADR+32*3+2), a  ; zápis atributu do atributové paměti
	jp  start                      ; opětovný test stisku klávesy

end ENTRY_POINT
