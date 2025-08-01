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
; Example #18:
;    Clear screen and opening I/O channel #2
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/18-cls.asm



ENTRY_POINT   equ $8000
ROM_CLS       equ $0DAF

        org ENTRY_POINT

start:
        call ROM_CLS    ; smazání obrazovky a otevření kanálu číslo 2 (screen)
        ret             ; návrat z programu do BASICu

end ENTRY_POINT
