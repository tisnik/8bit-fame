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
        mul  ebx                   ; nasobeni v FX-pointu do EDX:EAX
        mov  ax, dx                ; bity 16-32
        ror  eax, 16               ; prohodit horni a spodni polovinu registru
        print_hex eax

finish:
        wait_key                   ; cekani na klavesu
        exit                       ; navrat do DOSu


; datova cast
section .data

section .bss


