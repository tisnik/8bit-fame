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
; Example #26:
;    Change text position on screen via control characters
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/26-print-at.asm



ENTRY_POINT      equ $8000
ROM_OPEN_CHANNEL equ $1601

AT               equ 0x16

        org ENTRY_POINT

start:
        ld   A,2              ; číslo kanálu
        call ROM_OPEN_CHANNEL ; otevření kanálu číslo 2 (screen)

        ld   A, AT            ; řídicí kód pro specifikaci pozice psaní
        rst  0x10             ; zavolání rutiny v ROM

        ld   A, 16            ; y-ová souřadnice
        rst  0x10             ; zavolání rutiny v ROM

        ld   A, 31            ; x-ová souřadnice
        rst  0x10             ; zavolání rutiny v ROM

        ld   A, 42            ; kód znaku '*' pro tisk
        rst  0x10             ; zavolání rutiny v ROM

        ret                   ; návrat z programu do BASICu

end ENTRY_POINT
