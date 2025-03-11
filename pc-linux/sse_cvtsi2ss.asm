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

;-----------------------------------------------------------------------------
section .bss
sse_tmp resb 16

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        mov eax, 2
        cvtsi2ss xmm0, eax           ; konverze jednoho prvku
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        mov eax, 100000
        cvtsi2ss xmm0, eax           ; konverze jednoho prvku
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        mov eax, 0xffffffff
        cvtsi2ss xmm0, eax           ; konverze jednoho prvku
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

        exit                         ; ukonceni procesu


%include "hex2string.asm"
