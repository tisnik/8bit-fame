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
