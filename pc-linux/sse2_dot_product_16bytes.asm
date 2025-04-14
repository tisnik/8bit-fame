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
sse_val_1 db 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
sse_val_2 db 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1

;-----------------------------------------------------------------------------
section .bss
sse_tmp resb 16

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        mov ebx, sse_val_1           ; adresa prvniho vektoru
        movdqu xmm2, [ebx]           ; nacteni puvodniho vektoru do registru XMM2
        print_sse_reg_as_hex xmm2    ; tisk hodnoty registru XMM2

        mov ebx, sse_val_2           ; adresa druheho vektoru
        movdqu xmm1, [ebx]           ; nacteni puvodniho vektoru do registru XMM1
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        movdqa    xmm3, xmm2         ; kopie prvniho vektoru
        movdqa    xmm0, xmm1         ; kopie druheho vektor
        punpcklbw xmm3, xmm2         ; provedeni operace prolozeni hodnot z obou vektoru po bajtech
        punpcklbw xmm0, xmm1
        punpckhbw xmm2, xmm2         ; dtto
        punpckhbw xmm1, xmm1

        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1
        print_sse_reg_as_hex xmm2    ; tisk hodnoty registru XMM2
        print_sse_reg_as_hex xmm3    ; tisk hodnoty registru XMM3

        pmullw  xmm0, xmm3           ; součiny odpovídajících si prvku
        pmullw  xmm1, xmm2
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        mov     eax, 0x00ff00ff      ; 32bitová maska sudých bajtů
        movd    xmm2, eax
        print_sse_reg_as_hex xmm2    ; tisk hodnoty registru XMM2
        pshufd  xmm2, xmm2, 0        ; rozkopírování masky do všech dvouslov vektoru
        print_sse_reg_as_hex xmm2    ; tisk hodnoty registru XMM2

        pand    xmm0, xmm2           ; vymaskování sudých bajtů
        pand    xmm1, xmm2           ; vymaskování sudých bajtů
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0
        print_sse_reg_as_hex xmm1    ; tisk hodnoty registru XMM1

        packuswb xmm0, xmm1          ; proložení prvků vektorů
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        movdqa  xmm1, xmm0
        psrldq  xmm1, 8              ; bitový posun doleva
        paddb   xmm0, xmm1
        pxor    xmm1, xmm1           ; toto je taktéž proložení
        psadbw  xmm0, xmm1           ; součet
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        movd    eax, xmm0            ; výsledná hodnota do registru EAX
        print_hex eax, "*"
        exit                         ; ukonceni procesu


%include "hex2string.asm"
