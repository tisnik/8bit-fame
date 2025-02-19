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
 
psraw_message:
         db 0x0a, "psraw:", 0x0a
	 psraw_message_length equ $ - psraw_message
 
psrad_message:
         db 0x0a, "psrad:", 0x0a
	 psrad_message_length equ $ - psrad_message
 
 
mmx_val db 0, 0, 1, 0xff, 0, 0, 1, 0xff

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

	psraw mm1, 1                 ; aritmeticky posun doprava o jeden bit
        print_string psraw_message, psraw_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm2                ; obnovit hodnotu registru mm1
	psrad mm1, 1                 ; aritmeticky posun doprava o jeden bit
        print_string psrad_message, psrad_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
