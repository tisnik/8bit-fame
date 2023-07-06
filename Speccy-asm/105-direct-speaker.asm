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
; Example #105:
;    Direct speaker control via port.

ENTRY_POINT   equ $8000
BEEPER_PORT   equ $fe



	org ENTRY_POINT


start:
	ld   A, %00000111              ; původní hodnota zapisovaná na port
loop:
	xor  %00010000                 ; negace čtvrtého bitu
	out  (BEEPER_PORT), A          ; zápis na port
	call short_delay               ; počkat
	jr   loop                      ; a opakovat celé znovu


short_delay:
	; zpožďovací rutina
	; mění B (což nám nevadí)
        ld   b, 100                    ; počitadlo zpožďovací smyčky
delay_loop:
	djnz delay_loop                ; opakovat smyčku s počitadlem v B
	ret                            ; návrat z podprogramu

end ENTRY_POINT
