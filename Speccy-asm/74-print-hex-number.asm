; Example that is used in following article:
;    Aritmetické operace s hodnotami uloženými binárně i ve formátu BCD
;    https://www.root.cz/clanky/aritmeticke-operace-s-hodnotami-ulozenymi-binarne-i-ve-formatu-bcd/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #74:
;    Print hexadecimal number (naive implementation).

ENTRY_POINT   equ $8000
ROM_CLS       equ $0DAF
OUT_NUM_1     equ $1A1B


	org ENTRY_POINT

start:
	call ROM_CLS        ; smazání obrazovky a otevření kanálu číslo 2 (screen)

	ld   A, 0x00        ; vytisknout hexa hodnotu s přechodem na nový řádek
	call print_hex_number
	call new_line

	ld   A, 0x01        ; vytisknout hexa hodnotu s přechodem na nový řádek
	call print_hex_number
	call new_line

	ld   A, 0x09        ; vytisknout hexa hodnotu s přechodem na nový řádek
	call print_hex_number
	call new_line

	ld   A, 0x99        ; vytisknout hexa hodnotu s přechodem na nový řádek
	call print_hex_number
	call new_line

	ld   A, 0x0a        ; vytisknout hexa hodnotu s přechodem na nový řádek
	call print_hex_number
	call new_line

	ld   A, 0xa0        ; vytisknout hexa hodnotu s přechodem na nový řádek
	call print_hex_number
	call new_line

	ld   A, 0xba        ; vytisknout hexa hodnotu s přechodem na nový řádek
	call print_hex_number
	call new_line

	ld   A, 0xff        ; vytisknout hexa hodnotu s přechodem na nový řádek
	call print_hex_number
	call new_line

	ret                 ; návrat z programu do BASICu

print_hex_number:
	push AF             ; uschovat A pro pozdější využití
	rrca                ; rotace o čtyři bity doprava
	rrca
	rrca
	rrca
	and  $0f            ; zamaskovat horní čtyři bity
	call print_hex_digit; vytisknout hexa číslici

	pop  AF             ; obnovit A
	and  $0f            ; zamaskovat horní čtyři bity
	call print_hex_digit; vytisknout hexa číslici
	ret                 ; a návrat z podprogramu

print_hex_digit:
	cp   0x0a           ; test, jestli je číslice menší než 10
	jr c, print_0_to_9  ; ok, hodnota je menší než 10, budeme tedy tisknout desítkovou číslici
	add  A, 65-10       ; ASCII kód znaku 'A', ovšem začínáme od desítky, ne od nuly
	rst  0x10           ; zavolání rutiny v ROM pro tisk jednoho znaku
	ret                 ; návrat ze subrutiny
print_0_to_9:
	add  A, 48          ; ASCII kód znaku '0'
	rst  0x10           ; zavolání rutiny v ROM pro tisk jednoho znaku
	ret                 ; návrat ze subrutiny

new_line:
	ld   A, 0x0d        ; kód znaku pro odřádkování
	rst  0x10           ; zavolání rutiny v ROM
	ret                 ; návrat ze subrutiny


end ENTRY_POINT
