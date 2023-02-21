ENTRY_POINT      equ $8000
ROM_OPEN_CHANNEL equ $1601
ROM_PRINT        equ $203C
ATTR_T           equ 23695

INK              equ $10
PAPER            equ $11
FLASH            equ $12
BRIGHT           equ $13
INVERSE          equ $14

BLACK_COLOR      equ %000
BLUE_COLOR       equ %001
RED_COLOR        equ %010
MAGENTA_COLOR    equ %011
GREEN_COLOR      equ %100
CYAN_COLOR       equ %101
YELLOW_COLOR     equ %110
WHITE_COLOR      equ %111


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
TEXT:	db "Hello, speccy!", PAPER, RED_COLOR

TEXT_LENGTH: equ $ - TEXT

end ENTRY_POINT
