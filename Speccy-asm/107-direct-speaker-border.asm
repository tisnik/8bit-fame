ENTRY_POINT   equ $8000
BEEPER_PORT   equ $fe



	org ENTRY_POINT


start:
	ld   A, %00000111              ; původní hodnota zapisovaná na port
loop:
	xor  %00010001                 ; negace prvního a čtvrtého bitu
	out  (BEEPER_PORT), A          ; zápis na port
	call short_delay               ; počkat
	jr   loop                      ; a opakovat celé znovu


short_delay:
	; zpožďovací rutina
	; mění B (což nám nevadí)
        ld   b, 98                    ; počitadlo zpožďovací smyčky
delay_loop:
	djnz delay_loop                ; opakovat smyčku s počitadlem v B
	ret                            ; návrat z podprogramu

end ENTRY_POINT
