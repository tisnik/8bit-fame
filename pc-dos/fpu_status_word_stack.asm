;-----------------------------------------------------------------------------
; Precteni stavoveho slova matematickeho koprocesoru
; Změna obsazení zásobníku: vliv na obsah stavového slova
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Matematické koprocesory na platformě 80×86 prakticky
; https://www.root.cz/clanky/matematicke-koprocesory-na-platforme-80x86-prakticky/
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
        call print_status_word     ; tisk stavového slova

        fldz                       ; uložení hodnoty na zásobník
        call print_status_word     ; tisk stavového slova

        fldz                       ; uložení druhé hodnoty na zásobník
        call print_status_word     ; tisk stavového slova

        fldz                       ; uložení třetí hodnoty na zásobník
        call print_status_word     ; tisk stavového slova

        faddp                      ; výpočet s odstraněním původní hodnoty
        call print_status_word     ; tisk stavového slova

        faddp                      ; výpočet s odstraněním původní hodnoty
        call print_status_word     ; tisk stavového slova

        faddp                      ; výpočet s odstraněním původní hodnoty
        call print_status_word     ; tisk stavového slova

        faddp                      ; nyní by měl zásobník "podtéct"
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
