[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message
 
align 16
sse_val_1 dd 4.0, 3.0, 2.0, 1.0
sse_val_2 dd 1.0, 7.0, 6.0, 5.0

;-----------------------------------------------------------------------------
section .bss
sse_tmp resb 16

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru


_start:
        mov ebx, sse_val_1
        movaps xmm1, [ebx]           ; nacteni prvni hodnoty do registru XMM1

        mov ebx, sse_val_2
        movaps xmm0, [ebx]           ; nacteni druhe hodnoty do registru XMM0

        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        mulps   xmm0, xmm1           ; soucin vektoru prvek po prvku
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        movaps  xmm1, xmm0
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        movhlps xmm1, xmm0
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        addps   xmm1, xmm0
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        movaps  xmm0, xmm1
        shufps  xmm0, xmm1, 85
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        addps   xmm0, xmm1
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
