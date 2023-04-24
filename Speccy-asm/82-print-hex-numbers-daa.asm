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

ENTRY_POINT   equ $8000
ROM_CLS       equ $0DAF
OUT_NUM_1     equ $1A1B


	org ENTRY_POINT

start:
	call ROM_CLS           ; smazání obrazovky a otevření kanálu číslo 2 (screen)

	ld   HL, numbers       ; statické pole s hodnotami, které se mají vytisknout + zarážkou
loop:
	ld   A, (HL)           ; načíst další hodnotu ze statického pole
	or   A                 ; test na nulu
	ret  z                 ; návrat z programu do BASICU
	inc  HL                ; adresa dalšího prvku v poli
	call print_hex_number  ; tisk hexadecimální hodnoty
	call new_line          ; s přechodem na nový řádek
	jp   loop              ; zpracování další hodnoty

numbers:
	db 0x01, 0x02, 0x09, 0x0a, 0x10, 0x99, 0xa0, 0xaa, 0xaf, 0xf0, 0xff, 0x00

print_hex_number:
	push AF             ; uschovat A pro pozdější využití
	rrca                ; rotace o čtyři bity doprava
	rrca
	rrca
	rrca
	call print_hex_digit; vytisknout první hexa cifru

	pop  AF             ; obnovit A
	                    ; vytisknout druhou hexa cifru

print_hex_digit:
	or   $f0            ; nastavit horní čtyři bity + příznaky
	daa                 ; desítková korekce pro původní hodnoty A-F
	add A, $a0          ; přičtení konstanty
	adc A, $40          ; přičtení konstanty a navíc i příznaku carry
	rst  0x10           ; zavolání rutiny v ROM pro tisk jednoho znaku
	ret                 ; návrat ze subrutiny

new_line:
	ld   A, 0x0d        ; kód znaku pro odřádkování
	rst  0x10           ; zavolání rutiny v ROM
	ret                 ; návrat ze subrutiny


end ENTRY_POINT
