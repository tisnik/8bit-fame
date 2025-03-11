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
 
;-----------------------------------------------------------------------------
section .bss
csr_value resb 16

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        mov ebx, csr_value           ; adresa s místem pro uložení obsahu registru MXCSR
	stmxcsr [ebx]                ; uložení hodnoty MXCSR

        mov eax, [ebx]
	print_hex eax, 10

        exit                         ; ukonceni procesu


%include "hex2string.asm"
