;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
;
; Pokročilejší SSE operace: přeskupení, promíchání a rozbalování prvků vektorů
; https://www.root.cz/clanky/pokrocilejsi-sse-operace-preskupeni-promichani-a-rozbalovani-prvku-vektoru/
; 

[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message
 
align 16
sse_val_1 dd 0x00000000, 0x11111111, 0x22222222, 0x33333333
sse_val_2 dd 0x44444444, 0x55555555, 0x66666666, 0x77777777

;-----------------------------------------------------------------------------
section .bss
sse_tmp resb 16

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        mov ebx, sse_val_1
        movaps xmm0, [ebx]           ; nacteni prvni hodnoty do registru XMM0
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        mov ebx, sse_val_2
        movaps xmm1, [ebx]           ; nacteni druhe hodnoty do registru XMM1
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        shufps xmm0, xmm1, 0b00000000 ; proložení prvků vektorů
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        mov ebx, sse_val_1
        movaps xmm0, [ebx]           ; nacteni prvni hodnoty do registru XMM0
        shufps xmm0, xmm1, 0b00000001 ; proložení prvků vektorů
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        mov ebx, sse_val_1
        movaps xmm0, [ebx]           ; nacteni prvni hodnoty do registru XMM0
        shufps xmm0, xmm1, 0b00000010 ; proložení prvků vektorů
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        mov ebx, sse_val_1
        movaps xmm0, [ebx]           ; nacteni prvni hodnoty do registru XMM0
        shufps xmm0, xmm1, 0b00000011 ; proložení prvků vektorů
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        mov ebx, sse_val_1
        movaps xmm0, [ebx]           ; nacteni prvni hodnoty do registru XMM0
        shufps xmm0, xmm1, 0b01010101 ; proložení prvků vektorů
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        mov ebx, sse_val_1
        movaps xmm0, [ebx]           ; nacteni prvni hodnoty do registru XMM0
        shufps xmm0, xmm1, 0b01100110 ; proložení prvků vektorů
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        mov ebx, sse_val_1
        movaps xmm0, [ebx]           ; nacteni prvni hodnoty do registru XMM0
        shufps xmm0, xmm1, 0b00110011 ; proložení prvků vektorů
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        mov ebx, sse_val_1
        movaps xmm0, [ebx]           ; nacteni prvni hodnoty do registru XMM0
        shufps xmm0, xmm1, 0b11111111 ; proložení prvků vektorů
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        exit                         ; ukonceni procesu


%include "hex2string.asm"
