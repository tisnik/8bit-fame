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
; Example #96:
;    Keypress detection for all five keys in one row.
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/96-keypress-row.asm



ATTRIBUTE_ADR equ $5800
ENTRY_POINT   equ $8000
ROM_CLS       equ $0DAF

        org ENTRY_POINT

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


printChar MACRO character
        ld   a, character
        rst  0x10       ; zavolání rutiny v ROM
ENDM

changeAttribute MACRO attribute
        ld  (hl), attribute
        inc hl
ENDM


start:
        call ROM_CLS    ; smazání obrazovky a otevření kanálu číslo 2 (screen)

        printChar '^'   ; tisk pětice znaků na obrazovku
        printChar 'Z'
        printChar 'X'
        printChar 'C'
        printChar 'V'

keypress:
        ld  bc, KB_ROW_0_PORT          ; adresa portu, ze kterého budeme číst údaje
        in  a, (c)                     ; vlastní čtení z portu (5 bitů)

        ld  hl, ATTRIBUTE_ADR          ; adresa, od které budeme měnit barvové atributy
        ld  b, 5                       ; počet atributů + počet testovaných kláves
next_key:
        srl a                          ; přesunout kód stisku klávesy do příznaku carry
        jr  nc, key_pressed            ; test stisku klávesy
        changeAttribute WHITE_COLOR << 3
        jr  next                       ; test další klávesy
key_pressed:
        changeAttribute INTENSITY_BIT | (RED_COLOR << 3)
next:
        djnz next_key                  ; opakovat celou smyčku 5x
        jp   keypress                  ; další test stisku kláves


end ENTRY_POINT
