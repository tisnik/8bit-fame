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
 
sse_val dd 0.0, 1.0, -1.0, 2.0

;-----------------------------------------------------------------------------
section .bss
sse_tmp resb 16

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        mov ebx, sse_val
        movaps xmm0, [ebx]           ; nacteni hodnoty do registru XMM0
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        exit                         ; ukonceni procesu


%include "hex2string.asm"
