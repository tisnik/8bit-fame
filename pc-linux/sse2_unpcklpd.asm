[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message
 
align 16
sse_val_1 dq 0x1111111111111111, 0x2222222222222222
sse_val_2 dq 0x3333333333333333, 0x4444444444444444

;-----------------------------------------------------------------------------
section .bss
sse_tmp resb 16

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        mov ebx, sse_val_1           ; adresa prvniho vektoru
        movdqu xmm0, [ebx]           ; nacteni puvodniho vektoru do registru XMM0
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        mov ebx, sse_val_2           ; adresa druheho vektoru
        movdqu xmm1, [ebx]           ; nacteni puvodniho vektoru do registru XMM1
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM0

        unpcklpd xmm0, xmm1          ; ziskani dolnich polovin z obou vektoru

        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        exit                         ; ukonceni procesu


%include "hex2string.asm"
