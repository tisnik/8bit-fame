[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
	 db ' '
	 hex_message_length equ $ - hex_message
 
packswb_message:
         db 0x0a, "packswb:", 0x0a
	 packswb_message_length equ $ - packswb_message
 
 
 
 
mmx_val_1 dw 0x0000, 0x0100, 0x0200, 0x0300
mmx_val_2 dw 0x0400, 0x0500, 0x0600, 0x0700

;-----------------------------------------------------------------------------
section .bss
mmx_tmp resb 8

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
	emms                         ; inicializace MMX
	mov ebx, mmx_val_1
	movq mm1, [ebx]              ; nacteni prvni hodnoty do registru MM1
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

	mov ebx, mmx_val_2
	movq mm2, [ebx]              ; nacteni druhe hodnoty do registru MM2
	print_mmx_reg_as_hex mm2     ; tisk hodnoty registru MM2

	packsswb mm1, mm2            ; zkombinovani obsahu dvou vektoru
        print_string packswb_message, packswb_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
