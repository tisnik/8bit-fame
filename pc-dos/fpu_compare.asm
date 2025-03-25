;-----------------------------------------------------------------------------
; Porovnani dvou FP hodnot.
; Precteni stavoveho slova matematickeho koprocesoru
; Ulozeni priznaku do registru FLAGS
; Rozeskok na zaklade nastavenych priznaku
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Matematické koprocesory na platformě x86: vše se komplikuje
; https://www.root.cz/clanky/matematicke-koprocesory-na-platforme-x86-vse-se-komplikuje/
;
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
        call print_comparison_results     ; tisk výsledku porovnání

        fninit                     ; inicializace koprocesoru
        fld1                       ; uložení konstanty 1 na zásobník
        fld1                       ; uložení konstanty 1 na zásobník
        fcompp                     ; porovnání dvou hodnot s jejich odstraněním ze zásobníku
        call print_comparison_results     ; tisk výsledku porovnání

        fninit                     ; inicializace koprocesoru
        fld1                       ; uložení konstanty 1 na zásobník
        fldz                       ; uložení konstanty 0 na zásobník
        fcompp                     ; porovnání dvou hodnot s jejich odstraněním ze zásobníku
        call print_comparison_results     ; tisk výsledku porovnání

        fninit                     ; inicializace koprocesoru
        fldz                       ; uložení konstanty 0 na zásobník
        fld1                       ; uložení konstanty 1 na zásobník
        fcompp                     ; porovnání dvou hodnot s jejich odstraněním ze zásobníku
        call print_comparison_results     ; tisk výsledku porovnání

        fninit                     ; inicializace koprocesoru
        fld1                       ; uložení konstanty 1 na zásobník
        fldz                       ; uložení konstanty 0 na zásobník
        fdivp                      ; na zásobník se uloží nekonečno
        fld1                       ; uložení konstanty 1 na zásobník
        fcompp                     ; porovnání dvou hodnot s jejich odstraněním ze zásobníku
        call print_comparison_results     ; tisk výsledku porovnání

        fninit                     ; inicializace koprocesoru
        fld1
        fchs                       ; změna znaménka
        fsqrt                      ; odmocnina z -1
        fldz                       ; uložení konstanty 0 na zásobník
        fcompp                     ; porovnání dvou hodnot s jejich odstraněním ze zásobníku
        call print_comparison_results     ; tisk výsledku porovnání

        wait_key                   ; cekani na klavesu
        exit                       ; navrat do DOSu

;-----------------------------------------------------------------------------

print_comparison_results:
        fnstsw word [test_word]    ; ulozeni stavoveho slova
        mov ax, word [test_word]
        sahf                       ; uložení do příznakového registru

        jnp not_unordered
        print_string msg_unordered
        ret
not_unordered:
        jnz not_equal
        print_string msg_equal_values
        ret
not_equal:
        jnc greater_than
        print_string msg_less_than
        ret
greater_than:
        print_string msg_greater_than
        ret

; datova cast
msg_greater_than: db "Greater than", 0x0d, 0x0a, "$"
msg_less_than:    db "Less than", 0x0d, 0x0a, "$"
msg_equal_values: db "Equal values", 0x0d, 0x0a, "$"
msg_unordered:    db "Unordered values!", 0x0d, 0x0a, "$"

; datova cast
test_word: dw 0
