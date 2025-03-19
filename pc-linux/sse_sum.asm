[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message
 
align 16
sse_val_1 dd 0x1, 0x10, 0x100, 0x1000

;-----------------------------------------------------------------------------
section .bss
sse_tmp resb 16

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        mov ebx, sse_val_1
        movaps xmm0, [ebx]           ; nacteni prvni hodnoty do registru XMM0

        movaps  xmm1, xmm0           ; xmm1 := xmm0
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        movhlps xmm1, xmm0           ; přesun nejvyšších dvou prvků vektoru
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        addps   xmm1, xmm0           ; vektorový součet
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        movaps  xmm0, xmm1
        shufps  xmm0, xmm1, 85       ; proložení prvků vektorů
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        addps   xmm0, xmm1           ; vektorový součet
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        exit                         ; ukonceni procesu


%include "hex2string.asm"
