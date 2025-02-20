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
 
pcmpgtb_message:
         db 0x0a, "pcmpgtb:", 0x0a
         pcmpgtb_message_length equ $ - pcmpgtb_message
 
pcmpgtw_message:
         db 0x0a, "pcmpgtw:", 0x0a
         pcmpgtw_message_length equ $ - pcmpgtw_message
 
pcmpgtd_message:
         db 0x0a, "pcmpgtd:", 0x0a
         pcmpgtd_message_length equ $ - pcmpgtd_message
 
 
mmx_val_1 db 0, 1, 2, 3, 0, 1, 2, 3
mmx_val_2 db 1, 2, 3, 0, 1, 0, 3, 0

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

        pcmpgtb mm1, mm2             ; porovnani prvku vektoru na rovnost
        print_string pcmpgtb_message, pcmpgtb_message_length
        print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm3                ; obnovit hodnotu registru mm1
        movq mm2, mm4                ; obnovit hodnotu registru mm2
        pcmpgtw mm1, mm2             ; porovnani prvku vektoru na rovnost
        print_string pcmpgtw_message, pcmpgtw_message_length
        print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm3                ; obnovit hodnotu registru mm1
        movq mm2, mm4                ; obnovit hodnotu registru mm2
        pcmpgtd mm1, mm2             ; porovnani prvku vektoru na rovnost
        print_string pcmpgtd_message, pcmpgtd_message_length
        print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
