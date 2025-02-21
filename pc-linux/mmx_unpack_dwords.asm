;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; SIMD instrukce na 80×86: dokončení popisu MMX, instrukce 3DNow!
; https://www.root.cz/clanky/simd-instrukce-na-80-86-dokonceni-popisu-mmx-instrukce-3dnow/

[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message
 
punpckldq_message:
         db 0x0a, "punpckldq:", 0x0a
         punpckldq_message_length equ $ - punpckldq_message
 
punpckhdq_message:
         db 0x0a, "punpckhdq:", 0x0a
         punpckhdq_message_length equ $ - punpckhdq_message
 
 
 
mmx_val_1 dd 0x00000000, 0x11111111
mmx_val_2 dd 0x22222222, 0x33333333

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
        movq mm2, [ebx]              ; nacteni druhe hodnoty do registru MM2
        print_mmx_reg_as_hex mm2     ; tisk hodnoty registru MM2

        movq mm3, mm1                ; zapamatovat si hodnotu pro další použití
        movq mm4, mm2                ; zapamatovat si hodnotu pro další použití

        punpckldq mm1, mm2           ; zkombinovani obsahu dvou vektoru
        print_string punpckldq_message, punpckldq_message_length
        print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm3                ; obnovit hodnotu registru mm1
        movq mm2, mm4                ; obnovit hodnotu registru mm2
        punpckhdq mm1, mm2           ; zkombinovani obsahu dvou vektoru
        print_string punpckhdq_message, punpckhdq_message_length
        print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
