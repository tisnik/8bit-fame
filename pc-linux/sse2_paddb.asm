;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; 
; SIMD instrukce v rozšíření SSE
; https://www.root.cz/clanky/simd-instrukce-v-rozsireni-sse/

[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message
 
align 16
sse_val_1 db 0x00, 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70, 0x80, 0x90, 0xa0, 0xb0, 0xc0, 0xd0, 0xe0, 0xf0
sse_val_2 db 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,

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

        paddb xmm0, xmm1             ; soucet vektoru po bajtech
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0
        exit                         ; ukonceni procesu


%include "hex2string.asm"
