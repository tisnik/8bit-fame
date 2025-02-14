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
 
separator:
         db 0x0a
         separator_length equ $ - separator
 
mmx_val_1 dw 1, 2, 3, 4
mmx_val_2 dw 1, 1, 1, 1

mmx_val_3 dw 1, 2, 3, 4
mmx_val_4 dw 2, 2, 2, 2

mmx_val_5 dw 1, 2, 3, 4
mmx_val_6 dw 0xff, 0xff, 0xff, 0xff

mmx_val_7 dw 1, 2, 3, 4
mmx_val_8 dw 0x4000, 0x4000, 0x4000, 0x4000

;-----------------------------------------------------------------------------
section .bss
mmx_tmp resb 8

%macro perform_maddwd 2
        emms                         ; inicializace MMX
        mov ebx, %1
        movq mm1, [ebx]              ; nacteni prvni hodnoty do registru MM1
        print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        mov ebx, %2
        movq mm2, [ebx]              ; nacteni druhe hodnoty do registru MM1
        print_mmx_reg_as_hex mm2     ; tisk hodnoty registru MM2

        pmaddwd mm1, mm2             ; soucin hodnot se souctem mezivysledku

        print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        print_string separator, separator_length
%endmacro

;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        perform_maddwd mmx_val_1, mmx_val_2
        perform_maddwd mmx_val_3, mmx_val_4
        perform_maddwd mmx_val_5, mmx_val_6
        perform_maddwd mmx_val_7, mmx_val_8

        exit                         ; ukonceni procesu


%include "hex2string.asm"
