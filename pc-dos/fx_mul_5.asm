;-----------------------------------------------------------------------------
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Výpočty v systému pevné řádové čárky na platformě IBM PC (2. část)
; https://www.root.cz/clanky/vypocty-v-systemu-pevne-radove-carky-na-platforme-ibm-pc-2-cast/
;
;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        jmp main                   ; skok na zacatek kodu

%include "io.asm"                  ; nacist symboly, makra a podprogramy
%include "print.asm"               ; nacist symboly, makra a podprogramy

P       equ     65536              ; poloha desetinne tecky v FX-pointu

x       equ     2 * P              ; konstanty, ktere se budou nasobit
y       equ     P / 512

main:
        mov  eax, x
        print_hex eax              ; vytisknout hodnotu prvni konstanty

        mov  eax, y
        print_hex eax              ; vytisknout hodnotu druhe konstanty

        mov  eax, x
        mov  ebx, y
        shr  eax, 8                ; posun jeste pred nasobenim (ztrata presnosti)
        shr  ebx, 8                ; posun jeste pred nasobenim (ztrata presnosti)
        mul  ebx                   ; nasobeni v FX-pointu do EDX:EAX
        print_hex eax

finish:
        wait_key                   ; cekani na klavesu
        exit                       ; navrat do DOSu


; datova cast
section .data

section .bss


