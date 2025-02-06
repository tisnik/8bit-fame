[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message
 
mmx_val_1 dw 1, 2, 3, 4
mmx_val_2 dw 20000, 20000, 20000, 20000

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

        pmulhw mm1, mm2              ; soucin hodnot ve vektoru slovo po slovu

        print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
