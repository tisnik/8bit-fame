[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message
 
align 16
sse_val_1 dd 0xffffffff, 0x33333333, 0x11111111, 0x00000000
sse_val_2 dd 0x01020304, 0x01020304, 0x01020304, 0x01020304

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

        mov ebx, sse_val_2
        movdqu xmm1, [ebx]           ; nacteni puvodniho vektoru do registru XMM0
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1
	
	movdqu xmm2, xmm0
	pand xmm2, xmm1              ; prvni varianta bitoveho soucinu
        print_sse_reg_as_hex xmm2    ; tisk hodnoty registru XMM2

	movdqu xmm2, xmm0
	andps xmm2, xmm1             ; druha varianta bitoveho soucinu
        print_sse_reg_as_hex xmm2    ; tisk hodnoty registru XMM2

	movdqu xmm2, xmm0
	andpd xmm2, xmm1             ; treti varianta bitoveho soucinu
        print_sse_reg_as_hex xmm2    ; tisk hodnoty registru XMM2

        exit                         ; ukonceni procesu


%include "hex2string.asm"
