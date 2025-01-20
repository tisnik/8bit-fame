;-----------------------------------------------------------------------------
; Zakladni aritmeticke operace provadena matematickym koprocesorem: deleni
; s otocenymi operandy.
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
;-----------------------------------------------------------------------------

org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        jmp main             ; skok na zacatek kodu

%include "io.asm"            ; nacist symboly, makra a podprogramy
%include "print.asm"         ; nacist symboly, makra a podprogramy

main:
        fld1                 ; nacteni FP konstanty 1.0
        fld1                 ; nacteni FP konstanty 1.0
        fld1                 ; nacteni FP konstanty 1.0
        faddp                ; součet, takže na zásobníku budou konstanty 1.0 a 2.0
        fdivrp               ; vypocet podilu
        print_float32_as_hex ; zobrazeni FP hodnoty v hexadecimalnim tvaru

        wait_key             ; cekani na klavesu
        exit                 ; navrat do DOSu
