ENTRY_POINT      equ $8000
ROM_OPEN_CHANNEL equ $1601

	org ENTRY_POINT

start:
	ld   A,2              ; číslo kanálu
	call ROM_OPEN_CHANNEL ; otevření kanálu číslo 2 (screen)

	ld   HL, TEXT         ; adresa prvního znaku v řetězci

LOOP:
	ld   A, (HL)          ; načíst kód znaku z řetězce
	cp   0                ; test na kód znak s kódem 0
	ret  Z                ; ukončit program na konci řetězce

	rst  0x10             ; zavolání rutiny v ROM
	inc  HL               ; přechod na další znak
	jr   LOOP

; nulou ukončený řetězec
TEXT:	db "Hello, Speccy!", 0

end ENTRY_POINT