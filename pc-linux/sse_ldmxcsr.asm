;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
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
