;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; SIMD instrukce na platformě 80×86: instrukční sada MMX
; https://www.root.cz/clanky/simd-instrukce-na-platforme-80x86-instrukcni-sada-mmx/
;

[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message
 
paddusb_message:
         db 0x0a, "paddusb:", 0x0a
         paddusb_message_length equ $ - paddusb_message
 
paddusw_message:
         db 0x0a, "paddusw:", 0x0a
         paddusw_message_length equ $ - paddusw_message
 
mmx_val_1 db 1, 0, 0, 0, 0, 0, 0, 0
mmx_val_2 db 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,

;-----------------------------------------------------------------------------
section .bss
mmx_tmp resb 8

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        emms                         ; inicializace MMX
        mov ebx, mmx_val_1
        movq mm1, [ebx]              ; nacteni prvni hodnoty do registru MM1
        print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        mov ebx, mmx_val_2
        movq mm2, [ebx]              ; nacteni druhe hodnoty do registru MM1
        print_mmx_reg_as_hex mm2     ; tisk hodnoty registru MM2

        movq mm3, mm1                ; zapamatovat si hodnoty pro další použití
        movq mm4, mm2
        paddusb mm1, mm2             ; soucet hodnot ve vektoru bajt po bajtu
        print_string paddusb_message, paddusb_message_length
        print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm3                ; obnovit hodnoty vektoru
        movq mm2, mm4
        paddusw mm1, mm2             ; soucet hodnot ve vektoru bajt po slovech
        print_string paddusw_message, paddusw_message_length
        print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
