[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message
 
align 16
sse_val_1 dq -1.0, -2.0

;-----------------------------------------------------------------------------
section .bss
sse_tmp resb 16

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        mov ebx, sse_val_1
        movdqu xmm0, [ebx]           ; nacteni puvodniho vektoru do registru XMM0
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        sqrtpd xmm1, xmm0            ; odmocniny dvou hodnot typu double

        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
