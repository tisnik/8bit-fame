;-----------------------------------------------------------------------------
; Nacteni zakladnich FP konstant typu double do zasobniku matematickeho koprocesoru.
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Matematické koprocesory na 80×86 pro výpočty s plovoucí řádovou čárkou
; https://www.root.cz/clanky/matematicke-koprocesory-na-80-86-pro-vypocty-s-plovouci-radovou-carkou/
;
;-----------------------------------------------------------------------------

org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        jmp main             ; skok na zacatek kodu

%include "io.asm"            ; nacist symboly, makra a podprogramy
%include "print.asm"         ; nacist symboly, makra a podprogramy

main:
        fldz                 ; nacteni FP konstanty 0.0
        print_float64_as_hex ; zobrazeni FP hodnoty v hexadecimalnim tvaru

        fld1                 ; nacteni FP konstanty 1.0
        print_float64_as_hex ; zobrazeni FP hodnoty v hexadecimalnim tvaru

        fldpi                ; nacteni FP konstanty Pi
        print_float64_as_hex ; zobrazeni FP hodnoty v hexadecimalnim tvaru

        wait_key             ; cekani na klavesu
        exit                 ; navrat do DOSu

