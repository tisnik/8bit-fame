;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; 
; Rozšíření instrukční sady SSE2 v programech psaných v assembleru (dokončení)
; https://www.root.cz/clanky/rozsireni-instrukcni-sady-sse2-v-programech-psanych-v-assembleru-dokonceni/

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
sse_val_2 db 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31

;-----------------------------------------------------------------------------
section .bss
sse_tmp resb 16

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        mov ebx, sse_val_1           ; adresa prvniho vektoru
        movdqu xmm1, [ebx]           ; nacteni puvodniho vektoru do registru XMM1
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        mov ebx, sse_val_2           ; adresa druheho vektoru
        movdqu xmm2, [ebx]           ; nacteni puvodniho vektoru do registru XMM0
        print_sse_reg_as_hex xmm2    ; tisk hodnoty registru XMM2

        mov esi, 1                   ; konstanta, kterou budeme pricitat
        movd xmm0, esi               ; nacteni konstanty do druheho vektoru
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        punpcklbw xmm0, xmm0         ; prolozeni hodnot, zdrojem je jediny registr
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        punpcklwd xmm0, xmm0         ; prolozeni hodnot, zdrojem je jediny registr
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        pshufd xmm0, xmm0, 0         ; rozkopirovani spodnich osmi bajtu do celeho vektoru
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        paddb xmm1, xmm0             ; vektorovy soucet
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM0

        paddb xmm2, xmm0             ; vektorovy soucet
        print_sse_reg_as_hex xmm2    ; tisk hodnoty registru XMM0

        exit                         ; ukonceni procesu


%include "hex2string.asm"
