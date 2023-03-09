; Example that is used in following article:
;    Kouzlo minimalismu potřetí: vývoj her a dem pro slavné ZX Spectrum
;    https://www.root.cz/clanky/kouzlo-minimalismu-potreti-vyvoj-her-a-dem-pro-slavne-zx-spectrum/
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


	org ENTRY_POINT

start:
	ld a,BLINK_BIT | INTENSITY_BIT | (BLUE_COLOR << 3) | WHITE_COLOR
	ld (ATTRIBUTE_ADR),a
	ret
