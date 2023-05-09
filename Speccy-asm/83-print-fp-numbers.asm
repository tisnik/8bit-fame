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
; Example #83:
;    Print floating point number on screen using standard ROM call.

ENTRY_POINT   equ $8000
ROM_CLS       equ $0DAF
PRINT_FP      equ $2DE3
STK_STORE     equ $2AB6


	org ENTRY_POINT

start:
	call ROM_CLS           ; smazání obrazovky a otevření kanálu číslo 2 (screen)

	ld IX, fp0             ; adresa s pěticí bajtů FP hodnoty
	call print_fp_number   ; tisk FP hodnoty na obrazovku s odřádkováním

	ld IX, fp1             ; adresa s pěticí bajtů FP hodnoty
	call print_fp_number   ; tisk FP hodnoty na obrazovku s odřádkováním

	ld IX, fp2             ; adresa s pěticí bajtů FP hodnoty
	call print_fp_number   ; tisk FP hodnoty na obrazovku s odřádkováním

	ld IX, fp3             ; adresa s pěticí bajtů FP hodnoty
	call print_fp_number   ; tisk FP hodnoty na obrazovku s odřádkováním

	ld IX, fp4             ; adresa s pěticí bajtů FP hodnoty
	call print_fp_number   ; tisk FP hodnoty na obrazovku s odřádkováním

	ld IX, fp5             ; adresa s pěticí bajtů FP hodnoty
	call print_fp_number   ; tisk FP hodnoty na obrazovku s odřádkováním

	ld IX, fp6             ; adresa s pěticí bajtů FP hodnoty
	call print_fp_number   ; tisk FP hodnoty na obrazovku s odřádkováním

	ret

;         mantisa+128  s  exponent
fp0:	db %00000000, %00000000, %00000000, %00000000, %00000000
fp1:	db %10000000, %00000000, %00000000, %00000000, %00000000
fp2:	db %10000000, %10000000, %00000000, %00000000, %00000000
fp3:	db %10000000, %01000000, %00000000, %00000000, %00000000
fp4:	db %10000001, %01000000, %00000000, %00000000, %00000000
fp5:	db %10000001, %01000000, %00000000, %00000001, %00000000
fp6:	db %10000001, %00111111, %11111111, %11111111, %00000000


print_fp_number:
	; A  první bajt
	; B  pátý byte
	; C  čtvrtý byte
	; D  třetí byte
	; E  druhý bajt
	ld   A, (IX)
	ld   E, (IX+1)
	ld   D, (IX+2)
	ld   C, (IX+3)
	ld   B, (IX+4)
	call STK_STORE      ; uložit FP hodnotu na zásobník
	call PRINT_FP       ; vytisknout FP hodnotu uloženou na vrcholu zásobníku
new_line:
	ld   A, 0x0d        ; kód znaku pro odřádkování
	rst  0x10           ; zavolání rutiny v ROM
	ret                 ; návrat ze subrutiny


end ENTRY_POINT
