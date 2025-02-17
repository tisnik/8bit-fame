[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
	 db ' '
	 hex_message_length equ $ - hex_message
 
psrlw_message:
         db 0x0a, "psrlw:", 0x0a
	 psrlw_message_length equ $ - psrlw_message
 
psrld_message:
         db 0x0a, "psrld:", 0x0a
	 psrld_message_length equ $ - psrld_message
 
psrlq_message:
         db 0x0a, "psrlq:", 0x0a
	 psrlq_message_length equ $ - psrlq_message
 
 
mmx_val db 0, 1, 1, 1, 1, 0, 0, 0

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

	psrlw mm1, 1                 ; logicky posun doprava o jeden bit
        print_string psrlw_message, psrlw_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm2                ; obnovit hodnotu registru mm1
	psrld mm1, 1                 ; logicky posun doprava o jeden bit
        print_string psrld_message, psrld_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm2                ; obnovit hodnotu registru mm1
	psrlq mm1, 1                 ; logicky posun doprava o jeden bit
        print_string psrlq_message, psrlq_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
