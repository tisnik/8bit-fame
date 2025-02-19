;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; SIMD instrukce na 80×86: dokončení popisu MMX, instrukce 3DNow!
; https://www.root.cz/clanky/simd-instrukce-na-80-86-dokonceni-popisu-mmx-instrukce-3dnow/

[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
	 db ' '
	 hex_message_length equ $ - hex_message
 
psllw_message:
         db 0x0a, "psllw:", 0x0a
	 psllw_message_length equ $ - psllw_message
 
pslld_message:
         db 0x0a, "pslld:", 0x0a
	 pslld_message_length equ $ - pslld_message
 
psllq_message:
         db 0x0a, "psllq:", 0x0a
	 psllq_message_length equ $ - psllq_message
 
 
mmx_val db 0, 1, 2, 0xff, 0x00, 0xff, 0xff, 0x00

;-----------------------------------------------------------------------------
section .bss
mmx_tmp resb 8

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
	emms                         ; inicializace MMX
	mov ebx, mmx_val
	movq mm1, [ebx]              ; nacteni prvni hodnoty do registru MM1
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm2, mm1                ; zapamatovat si hodnotu pro další použití

	psllw mm1, 1                 ; logicky posun doleva o jeden bit
        print_string psllw_message, psllw_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm2                ; obnovit hodnotu registru mm1
	pslld mm1, 1                 ; logicky posun doleva o jeden bit
        print_string pslld_message, pslld_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm2                ; obnovit hodnotu registru mm1
	psllq mm1, 1                 ; logicky posun doleva o jeden bit
        print_string psllq_message, psllq_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
