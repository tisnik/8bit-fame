;-----------------------------------------------------------------------------
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Výpočty v systému pevné řádové čárky na platformě IBM PC
; https://www.root.cz/clanky/vypocty-v-systemu-pevne-radove-carky-na-platforme-ibm-pc/
;
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        jmp main                   ; skok na zacatek kodu

%include "io.asm"                  ; nacist symboly, makra a podprogramy
%include "print.asm"               ; nacist symboly, makra a podprogramy

P       equ     65536              ; poloha desetinne tecky v FX-pointu

main:
        mov  eax, 2 * P            ; konstanta v FX-pointu: 2.0
        print_hex eax

        mov  eax, 3 * P            ; konstanta v FX-pointu: 3.0
        print_hex eax

        mov  eax, 2 * P            ; konstanta v FX-pointu: 1.0
        mov  ebx, 3 * P            ; konstanta v FX-pointu: 2.0
        mul  ebx                   ; nasobeni v FX-pointu do EDX:EAX
        print_hex eax

        mov  eax, 1 * P / 2        ; konstanta v FX-pointu: 0.5
        print_hex eax

        mov  eax, 3 * P            ; konstanta v FX-pointu: 3.0
        print_hex eax

        mov  eax, 1 * P / 2        ; konstanta v FX-pointu: 0.5
        mov  ebx, 3 * P            ; konstanta v FX-pointu: 3.0
        mul  ebx                   ; nasobeni v FX-pointu do EDX:EAX
        print_hex eax

finish:
        wait_key                   ; cekani na klavesu
        exit                       ; navrat do DOSu


; datova cast
section .data

section .bss


