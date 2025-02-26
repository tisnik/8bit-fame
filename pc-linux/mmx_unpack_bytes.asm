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
 
punpcklbw_message:
         db 0x0a, "punpcklbw:", 0x0a
         punpcklbw_message_length equ $ - punpcklbw_message
 
punpckhbw_message:
         db 0x0a, "punpckhbw:", 0x0a
         punpckhbw_message_length equ $ - punpckhbw_message
 
 
 
mmx_val_1 db 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77
mmx_val_2 db 0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff

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

        punpcklbw mm1, mm2           ; zkombinovani obsahu dvou vektoru
        print_string punpcklbw_message, punpcklbw_message_length
        print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm3                ; obnovit hodnotu registru mm1
        movq mm2, mm4                ; obnovit hodnotu registru mm2
        punpckhbw mm1, mm2           ; zkombinovani obsahu dvou vektoru
        print_string punpckhbw_message, punpckhbw_message_length
        print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
