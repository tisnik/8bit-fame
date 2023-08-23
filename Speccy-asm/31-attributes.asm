; Example that is used in following article:
;    Vývoj her a dem pro ZX Spectrum: vlastní vykreslovací subrutiny
;    https://www.root.cz/clanky/vyvoj-her-a-dem-pro-zx-spectrum-vlastni-vykreslovaci-subrutiny/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #31:
;    Print string using attribute changed directly in memory.
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/31-attributes.asm



ENTRY_POINT      equ $8000
ROM_OPEN_CHANNEL equ $1601
ROM_PRINT        equ $203C
ATTR_T           equ 23695


	org ENTRY_POINT

start:
	ld   A,2              ; číslo kanálu
	call ROM_OPEN_CHANNEL ; otevření kanálu číslo 2 (screen)

	ld   B, 64            ; barva tisku
	ld   HL, ATTR_T       ; adresa systémové proměnné ATTR_T

loop:
	ld   (HL), B          ; změna barvy tisku
	push BC               ; uchovat BC
	ld   DE, TEXT         ; adresa prvního znaku v řetězci
	ld   BC, TEXT_LENGTH  ; délka textu
	call ROM_PRINT        ; volání subrutiny v ROM
	pop  BC               ; obnovit BC
	djnz loop             ; tisk další barvou
	ret                   ; ukončit program

; řetězec
TEXT:	db "Hello, speccy!"

TEXT_LENGTH: equ $ - TEXT

end ENTRY_POINT
