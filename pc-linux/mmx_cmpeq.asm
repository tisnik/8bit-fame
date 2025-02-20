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
 
pcmpeqb_message:
         db 0x0a, "pcmpeqb:", 0x0a
         pcmpeqb_message_length equ $ - pcmpeqb_message
 
pcmpeqw_message:
         db 0x0a, "pcmpeqw:", 0x0a
         pcmpeqw_message_length equ $ - pcmpeqw_message
 
pcmpeqd_message:
         db 0x0a, "pcmpeqd:", 0x0a
         pcmpeqd_message_length equ $ - pcmpeqd_message
 
 
mmx_val_1 db 0, 1, 2, 3, 0, 1, 2, 3
mmx_val_2 db 0, 1, 2, 9, 0, 9, 2, 9

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

        pcmpeqb mm1, mm2             ; porovnani prvku vektoru na rovnost
        print_string pcmpeqb_message, pcmpeqb_message_length
        print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm3                ; obnovit hodnotu registru mm1
        movq mm2, mm4                ; obnovit hodnotu registru mm2
        pcmpeqw mm1, mm2             ; porovnani prvku vektoru na rovnost
        print_string pcmpeqw_message, pcmpeqw_message_length
        print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm3                ; obnovit hodnotu registru mm1
        movq mm2, mm4                ; obnovit hodnotu registru mm2
        pcmpeqd mm1, mm2             ; porovnani prvku vektoru na rovnost
        print_string pcmpeqd_message, pcmpeqd_message_length
        print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
