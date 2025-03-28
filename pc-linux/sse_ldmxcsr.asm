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

csr_reset: dd 0x1f80
 
;-----------------------------------------------------------------------------
section .bss

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        mov ebx, csr_reset           ; adresa s obsahem registru MXCSR
        ldmxcsr [ebx]                ; načtení nové hodnoty

        exit                         ; ukonceni procesu


%include "hex2string.asm"
