; Precteni stavoveho slova matematickeho koprocesoru
;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS

;-----------------------------------------------------------------------------

org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        jmp main                   ; skok na zacatek kodu

%include "io.asm"                  ; nacist symboly, makra a podprogramy
%include "print.asm"               ; nacist symboly, makra a podprogramy

main:
        fninit                     ; inicializace koprocesoru
	fldz                       ; uložení konstanty 0 na zásobník
	fldz                       ; uložení konstanty 0 na zásobník
	fcompp                     ; porovnání dvou hodnot s jejich odstraněním ze zásobníku
	call print_status_word     ; tisk stavového slova

        fninit                     ; inicializace koprocesoru
	fld1                       ; uložení konstanty 1 na zásobník
	fld1                       ; uložení konstanty 1 na zásobník
	fcompp                     ; porovnání dvou hodnot s jejich odstraněním ze zásobníku
	call print_status_word     ; tisk stavového slova

        fninit                     ; inicializace koprocesoru
	fld1                       ; uložení konstanty 1 na zásobník
	fldz                       ; uložení konstanty 0 na zásobník
	fcompp                     ; porovnání dvou hodnot s jejich odstraněním ze zásobníku
	call print_status_word     ; tisk stavového slova

        fninit                     ; inicializace koprocesoru
	fldz                       ; uložení konstanty 0 na zásobník
	fld1                       ; uložení konstanty 1 na zásobník
	fcompp                     ; porovnání dvou hodnot s jejich odstraněním ze zásobníku
	call print_status_word     ; tisk stavového slova

        fninit                     ; inicializace koprocesoru
	fld1                       ; uložení konstanty 1 na zásobník
	fldz                       ; uložení konstanty 0 na zásobník
	fdivp                      ; na zásobník se uloží nekonečno
	fld1                       ; uložení konstanty 1 na zásobník
	fcompp                     ; porovnání dvou hodnot s jejich odstraněním ze zásobníku
	call print_status_word     ; tisk stavového slova

        fninit                     ; inicializace koprocesoru
	fld1
	fchs                       ; změna znaménka
	fsqrt                      ; odmocnina z -1
	fldz                       ; uložení konstanty 0 na zásobník
	fcompp                     ; porovnání dvou hodnot s jejich odstraněním ze zásobníku
	call print_status_word     ; tisk stavového slova

        wait_key                   ; cekani na klavesu
        exit                       ; navrat do DOSu

;-----------------------------------------------------------------------------

print_status_word:
        fnstsw word [test_word]    ; ulozeni stavoveho slova
	mov ax, word [test_word]
	print_hex_16 ax            ; tisk stavoveho slova v hexadecimalnim formatu
	ret

; datova cast
test_word: dw 0
