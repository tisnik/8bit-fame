[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
	 db ' '
	 hex_message_length equ $ - hex_message
 
pand_message:
         db 0x0a, "pand:", 0x0a
	 pand_message_length equ $ - pand_message
 
por_message:
         db 0x0a, "por:", 0x0a
	 por_message_length equ $ - por_message
 
pxor_message:
         db 0x0a, "pxor:", 0x0a
	 pxor_message_length equ $ - pxor_message
 
pandn_message:
         db 0x0a, "pandn:", 0x0a
	 pandn_message_length equ $ - pandn_message
 
mmx_val_1 db 0, 1, 2, 3, 0, 1, 2, 3
mmx_val_2 db 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00,

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
	movq mm2, [ebx]              ; nacteni druhe hodnoty do registru MM1
	print_mmx_reg_as_hex mm2     ; tisk hodnoty registru MM2

        movq mm3, mm1                ; zapamatovat si hodnoty pro další použití
	movq mm4, mm2

	pand mm1, mm2                ; bitova operace AND
        print_string pand_message, pand_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm3                ; obnovit hodnoty vektoru
	movq mm2, mm4
	por mm1, mm2                 ; bitova operace OR
        print_string por_message, por_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm3                ; obnovit hodnoty vektoru
	movq mm2, mm4
	pxor mm1, mm2                ; bitova operace XOR
        print_string pxor_message, pxor_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm3                ; obnovit hodnoty vektoru
	movq mm2, mm4
	pandn mm1, mm2               ; bitova operace AND NOT
        print_string pandn_message, pandn_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
