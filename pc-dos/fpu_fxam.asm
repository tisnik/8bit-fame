;-----------------------------------------------------------------------------
; Precteni stavoveho slova matematickeho koprocesoru
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
        fxam
        call print_status_word     ; tisk stavového slova

        fninit                     ; inicializace koprocesoru
        fld1                       ; uložení konstanty 1 na zásobník
        fxam
        call print_status_word     ; tisk stavového slova

        fninit                     ; inicializace koprocesoru
        fldpi                      ; uložení konstanty Pi na zásobník
        fxam
        call print_status_word     ; tisk stavového slova

        fninit                     ; inicializace koprocesoru
        fld1
        fchs                       ; změna znaménka původní konstanty 1
        fxam
        call print_status_word     ; tisk stavového slova

        fninit                     ; inicializace koprocesoru
        fld1
        fldz
        fdiv                       ; podíl 1/0
        fxam
        call print_status_word     ; tisk stavového slova

        fninit                     ; inicializace koprocesoru
        fldz
        fldz
        fdiv                       ; podíl 0/0
        fxam
        call print_status_word     ; tisk stavového slova

        fninit                     ; inicializace koprocesoru
        fld1
        fchs                       ; změna znaménka
        fsqrt                      ; odmocnina z -1
        fxam
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
