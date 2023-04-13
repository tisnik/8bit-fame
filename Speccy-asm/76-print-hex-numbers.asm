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
	db 0x01, 0x09, 0x99, 0xa0, 0xa0, 0xba, 0xff, 0x00

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
	jp print_hex_digit  ; vytisknout hexa číslici a návrat z podprogramu

print_hex_digit:
	cp   0x0a           ; test, jestli je číslice menší než 10
	jr c, print_0_to_9  ; ok, hodnota je menší než 10, budeme tedy tisknout desítkovou číslici
	add  A, 65-10-48    ; ASCII kód znaku 'A', ovšem začínáme od desítky, ne od nuly (+ update pro další ADD)
print_0_to_9:
	add  A, 48          ; ASCII kód znaku '0'
	rst  0x10           ; zavolání rutiny v ROM pro tisk jednoho znaku
	ret                 ; návrat ze subrutiny

new_line:
	ld   A, 0x0d        ; kód znaku pro odřádkování
	rst  0x10           ; zavolání rutiny v ROM
	ret                 ; návrat ze subrutiny


end ENTRY_POINT
