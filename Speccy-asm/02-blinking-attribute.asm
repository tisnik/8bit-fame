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
;
; Example #2:
;    Blinking color attribute
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/02-blinking-attribute.asm



        org $8000

start:
        ld a,%11010110
        ld ($5800),a
        ret
