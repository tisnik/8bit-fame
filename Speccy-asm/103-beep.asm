; Example that is used in following article:
;    Programujeme zvuky a hudbu na ZX Spectru
;    https://www.root.cz/clanky/programujeme-zvuky-a-hudbu-na-zx-spectru/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;

ENTRY_POINT   equ $8000
BEEPER        equ $03B5



	org ENTRY_POINT

beep MACRO pitch, duration
	ld   hl, pitch
	ld   de, duration
	call BEEPER
ENDM

start:
	beep 964, 1000                 ; přehrání noty
	ret                            ; návrat do BASICu


end ENTRY_POINT
