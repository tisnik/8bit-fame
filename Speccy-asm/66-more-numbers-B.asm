; Example that is used in following article:
;    Zobrazení čísel a zpracování příznaků mikroprocesoru Zilog Z80
;    https://www.root.cz/clanky/zobrazeni-cisel-a-zpracovani-priznaku-mikroprocesoru-zilog-z80/
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
	call ROM_CLS    ; smazání obrazovky a otevření kanálu číslo 2 (screen)
	ld   BC, 1      ; numerická hodnota, kterou chceme vytisknout
next_number:
	push BC         ; uchovat počitadlo
	call OUT_NUM_1  ; zavolání rutiny pro výpis celého čísla
	ld   A, 0x0d    ; kód znaku pro odřádkování
	rst  0x10       ; zavolání rutiny v ROM
	pop  BC         ; obnovit počitadlo
	inc  C          ; a zvýšit o jedničku
	ld   A, C
	cp   11         ; kontrola na konec smyčky
	jr   nz, next_number
	ret             ; návrat z programu do BASICu

end ENTRY_POINT
