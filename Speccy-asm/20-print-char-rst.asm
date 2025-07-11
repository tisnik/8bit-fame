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
; Example #20:
;    Clear screen and print character, ROM subroutine called via RST instruction
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/20-print-char-rst.asm



ENTRY_POINT   equ $8000
ROM_CLS       equ $0DAF

        org ENTRY_POINT

start:
        call ROM_CLS    ; smazání obrazovky a otevření kanálu číslo 2 (screen)
        ld   A, 42      ; kód znaku '*' pro tisk
        rst  0x10       ; zavolání rutiny v ROM
        ret             ; návrat z programu do BASICu

end ENTRY_POINT
