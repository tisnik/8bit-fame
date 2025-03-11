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
sse_val_1 dd 2.0, 3.0, 4.0, 5.0
sse_val_2 dd 10.0, 20.0, 30.0, 40.0

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

	cvtss2si eax, xmm0           ; konverze jednoho prvku
	print_hex eax, 10

        mov ebx, sse_val_2
        movaps xmm0, [ebx]           ; nacteni prvni hodnoty do registru XMM0
        print_sse_reg_as_hex xmm0    ; tisk hodnoty registru XMM0

	cvtss2si eax, xmm0           ; konverze jednoho prvku
	print_hex eax, 10

        exit                         ; ukonceni procesu


%include "hex2string.asm"
