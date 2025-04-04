[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message
 
align 16
sse_val_1 dd 0x11111111, 0x22222222, 0x33333333, 0x44444444

;-----------------------------------------------------------------------------
section .bss
sse_tmp resb 16

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        mov ebx, sse_val_1           ; adresa prvniho vektoru
        movdqu xmm0, [ebx]           ; nacteni puvodniho vektoru do registru XMM0
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM1

        pshufd xmm1, xmm0, 0         ; prolozeni obsahu dvou vektoru
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        pshufd xmm1, xmm0, 1         ; prolozeni obsahu dvou vektoru
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        pshufd xmm1, xmm0, 2         ; prolozeni obsahu dvou vektoru
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        pshufd xmm1, xmm0, 3         ; prolozeni obsahu dvou vektoru
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        pshufd xmm1, xmm0, 4         ; prolozeni obsahu dvou vektoru
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        pshufd xmm1, xmm0, 5         ; prolozeni obsahu dvou vektoru
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        pshufd xmm1, xmm0, 6         ; prolozeni obsahu dvou vektoru
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        pshufd xmm1, xmm0, 7         ; prolozeni obsahu dvou vektoru
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        pshufd xmm1, xmm0, 8         ; prolozeni obsahu dvou vektoru
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        pshufd xmm1, xmm0, 9         ; prolozeni obsahu dvou vektoru
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        pshufd xmm1, xmm0, 10        ; prolozeni obsahu dvou vektoru
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        pshufd xmm1, xmm0, 11        ; prolozeni obsahu dvou vektoru
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        pshufd xmm1, xmm0, 12        ; prolozeni obsahu dvou vektoru
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        pshufd xmm1, xmm0, 13        ; prolozeni obsahu dvou vektoru
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        pshufd xmm1, xmm0, 14        ; prolozeni obsahu dvou vektoru
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        pshufd xmm1, xmm0, 15        ; prolozeni obsahu dvou vektoru
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
