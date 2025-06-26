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
        shr  eax, 8                ; posun jeste pred nasobenim (ztrata presnosti)
        shr  ebx, 8                ; posun jeste pred nasobenim (ztrata presnosti)
        mul  ebx                   ; nasobeni v FX-pointu do EDX:EAX
        print_hex eax

        mov  eax, 1 * P / 2        ; konstanta v FX-pointu: 0.5
        print_hex eax

        mov  eax, 3 * P            ; konstanta v FX-pointu: 3.0
        print_hex eax

        mov  eax, 1 * P / 2        ; konstanta v FX-pointu: 0.5
        mov  ebx, 3 * P            ; konstanta v FX-pointu: 3.0
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


