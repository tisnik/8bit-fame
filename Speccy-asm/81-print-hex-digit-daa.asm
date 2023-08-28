; Example that is used in following article:
;    Tisk hexadecimálních hodnot s využitím instrukce DAA na ZX Spectru
;    https://www.root.cz/clanky/tisk-hexadecimalnich-hodnot-s-vyuzitim-instrukce-daa-na-zx-spectru/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #81:
;    Print hexadecimal digit, based on DAA instruction trick.
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/81-print-hex-digit-daa.asm



ENTRY_POINT   equ $8000
ROM_CLS       equ $0DAF
OUT_NUM_1     equ $1A1B


	org ENTRY_POINT

start:
	call ROM_CLS        ; smazání obrazovky a otevření kanálu číslo 2 (screen)

	xor  A              ; hodnota cifry, která se má vytisknout
	ld   B, 16          ; počitadlo smyčky
loop:	                    ; vytisknout hexa cifru s přechodem na nový řádek
	call print_hex_digit_nl
	inc  A              ; zvýšit hodnotu tištěné cifry
	djnz loop           ; opakování smyčky se snížením hodnoty počitadla

	ret                 ; návrat z programu do BASICu

print_hex_digit_nl:
	push AF             ; uschovat A pro pozdější využití
	or   $f0            ; nastavit horní čtyři bity + příznaky
	                    ; nyní je v A jedna z hodnot:
			    ;    0xf0 0xf1 0xf2 ... 0xf9 0xfa 0xfb 0xfc 0xfd 0xfe 0xff
	daa                 ; desítková korekce pro původní hodnoty A-F
	                    ; +  0x60 0x60 0x60 ... 0x60 0x66 0x66 0x66 0x66 0x66 0x66
	                    ; nyní je v A jedna z hodnot:
			    ;    0x50 0x51 0x52 ... 0x59 0x60 0x61 0x62 0x63 0x64 0x65
	add A, $a0          ; přičtení konstanty
	                    ; nyní je v A jedna z hodnot:
			    ;    0xf0 0xf1 0xf2 ... 0xf9 0x00 0x01 0x02 0x03 0x04 0x05
			    ; C    0    0    0        0    1    1    1    1    1    1
	adc A, $40          ; přičtení konstanty a navíc i příznaku carry
			    ;    0x30 0x31 0x31 ... 0x39 0x41 0x42 0x43 0x44 0x45 0x46
			    ; >   '0'  '1'  '2'      '9'  'A'  'B'  'C'  'D'  'E'  'F'
	rst  0x10           ; zavolání rutiny v ROM pro tisk jednoho znaku

new_line:
	ld   A, 0x0d        ; kód znaku pro odřádkování
	rst  0x10           ; zavolání rutiny v ROM
	pop  AF             ; obnovit A
	ret                 ; návrat ze subrutiny


end ENTRY_POINT
