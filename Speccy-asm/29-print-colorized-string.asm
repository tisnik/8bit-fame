ENTRY_POINT      equ $8000
ROM_OPEN_CHANNEL equ $1601

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

	ld   HL, TEXT         ; adresa prvního znaku v řetězci

LOOP:
	ld   A, (HL)          ; načíst kód znaku z řetězce
	and  a                ; test na kód znak s kódem 0
	ret  Z                ; ukončit program na konci řetězce

	rst  0x10             ; zavolání rutiny v ROM
	inc  HL               ; přechod na další znak
	jr   LOOP

; nulou ukončený řetězec
TEXT:	db PAPER, RED_COLOR, "Hello", INK, WHITE_COLOR, "Speccy", FLASH, 1, "!", 0

end ENTRY_POINT