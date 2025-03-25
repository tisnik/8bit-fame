;-----------------------------------------------------------------------------
; Precteni stavoveho slova matematickeho koprocesoru
; Zapis do registru FLAGS.
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
        ftst
        call print_test_result     ; tisk výsledku testu

        fninit                     ; inicializace koprocesoru
        fld1                       ; uložení konstanty 1 na zásobník
        ftst
        call print_test_result     ; tisk výsledku testu

        fninit                     ; inicializace koprocesoru
        fldpi                      ; uložení konstanty Pi na zásobník
        ftst
        call print_test_result     ; tisk výsledku testu

        fninit                     ; inicializace koprocesoru
        fld1
        fchs                       ; změna znaménka původní konstanty 1
        ftst
        call print_test_result     ; tisk výsledku testu

        fninit                     ; inicializace koprocesoru
        fld1
        fldz
        fdiv                       ; podíl 1/0
        ftst
        call print_test_result     ; tisk výsledku testu

        fninit                     ; inicializace koprocesoru
        fldz
        fldz
        fdiv                       ; podíl 0/0
        ftst
        call print_test_result     ; tisk výsledku testu

        fninit                     ; inicializace koprocesoru
        fld1
        fchs                       ; změna znaménka
        fsqrt                      ; odmocnina z -1
        ftst
        call print_test_result     ; tisk výsledku testu

        wait_key                   ; cekani na klavesu
        exit                       ; navrat do DOSu

;-----------------------------------------------------------------------------

; | ZF PF CF  stav
; |  0  0  0 ST(0) > 0                         | 
; |  0  0  1 ST(0) < 0                         | 
; |  1  0  0 ST(0) = 0                         | 
; |  1  1  1 ST(0) ? 0 (neporovnatelné hodnoty)| 

print_test_result:
        fnstsw word [test_word]    ; ulozeni stavoveho slova
        mov ax, word [test_word]
        sahf                       ; uložení do příznakového registru
        jnp not_unordered
        print_string msg_unordered
        ret
not_unordered:
        jnz not_zero
        print_string msg_zero_value
        ret
not_zero:
        jnc positive_value
        print_string msg_negative_value
        ret
positive_value:
        print_string msg_positive_value
        ret

; datova cast
msg_positive_value: db "Positive value", 0x0d, 0x0a, "$"
msg_negative_value: db "Negative value", 0x0d, 0x0a, "$"
msg_zero_value:     db "Zero value", 0x0d, 0x0a, "$"
msg_unordered:      db "Unordered values!", 0x0d, 0x0a, "$"

test_word: dw 0

