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

	cp   0x0a           ; test, jestli je číslice menší než 10
	jr c, print_0_to_9  ; ok, hodnota je menší než 10, budeme tedy tisknout desítkovou číslici
	add  A, 65-10-48    ; ASCII kód znaku 'A', ovšem začínáme od desítky, ne od nuly (+ update pro další ADD)
print_0_to_9:
	add  A, 48          ; ASCII kód znaku '0'
	rst  0x10           ; zavolání rutiny v ROM pro tisk jednoho znaku

new_line:
	ld   A, 0x0d        ; kód znaku pro odřádkování
	rst  0x10           ; zavolání rutiny v ROM
	pop  AF             ; obnovit A
	ret                 ; návrat ze subrutiny


end ENTRY_POINT
