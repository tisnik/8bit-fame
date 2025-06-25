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
;
; Example #94:
;    Changing one color attribute on screen.
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/94-color-attribute.asm



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
        ld a, INTENSITY_BIT | (BLUE_COLOR << 3) | RED_COLOR
        ld (ATTRIBUTE_ADR+32*3+2), a  ; zápis atributu do atributové paměti
        ret                           ; návrat do BASICu

end ENTRY_POINT
