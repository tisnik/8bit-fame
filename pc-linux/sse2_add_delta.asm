[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message
 
align 16
sse_val_1 db 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15

;-----------------------------------------------------------------------------
section .bss
sse_tmp resb 16

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        mov ebx, sse_val_1
        movdqu xmm1, [ebx]           ; nacteni puvodniho vektoru do registru XMM0
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM0

	mov esi, 1                   ; konstanta, kterou budeme pricitat
	movd xmm0, esi               ; nacteni konstanty do druheho vektoru
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        punpcklbw xmm0, xmm0         ; prolozeni hodnot, zdrojem je jediny registr
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        punpcklwd xmm0, xmm0         ; prolozeni hodnot, zdrojem je jediny registr
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        pshufd xmm0, xmm0, 0         ; rozkopirovani spodnich osmi bajtu do celeho vektoru
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        paddb xmm0, xmm1             ; vektorovy soucet
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        exit                         ; ukonceni procesu


%include "hex2string.asm"
