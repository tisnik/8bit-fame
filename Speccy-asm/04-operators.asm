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



attribute_adr equ $5800
entry_point   equ $8000

blink_bit     equ %10000000
intensity_bit equ %01000000
black_color   equ %000
blue_color    equ %001
red_color     equ %010
magenta_color equ %011
green_color   equ %100
cyan_color    equ %101
yellow_color  equ %110
white_color   equ %111


	org entry_point

start:
	ld a,blink_bit | intensity_bit | (blue_color << 3) | white_color
	ld (attribute_adr),a
	ret
