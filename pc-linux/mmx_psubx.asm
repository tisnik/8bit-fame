[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
	 db ' '
	 hex_message_length equ $ - hex_message
 
psubb_message:
         db 0x0a, "psubb:", 0x0a
	 psubb_message_length equ $ - psubb_message
 
psubw_message:
         db 0x0a, "psubw:", 0x0a
	 psubw_message_length equ $ - psubw_message
 
psubd_message:
         db 0x0a, "psubd:", 0x0a
	 psubd_message_length equ $ - psubd_message
 
psubq_message:
         db 0x0a, "psubq:", 0x0a
	 psubq_message_length equ $ - psubq_message
 
mmx_val_1 db 1, 0, 0, 0, 0, 0, 0, 0
mmx_val_2 db 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,

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

	psubb mm1, mm2               ; soucet hodnot ve vektoru bajt po bajtu
        print_string psubb_message, psubb_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm3                ; obnovit hodnoty vektoru
	movq mm2, mm4
	psubw mm1, mm2               ; soucet hodnot ve vektoru bajt po slovech
        print_string psubw_message, psubw_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm3                ; obnovit hodnoty vektoru
	movq mm2, mm4
	psubd mm1, mm2               ; soucet hodnot ve vektoru bajt po dvouslovech
        print_string psubd_message, psubd_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm3                ; obnovit hodnoty vektoru
	movq mm2, mm4
	psubq mm1, mm2               ; soucet hodnot ve vektoru bajt po ctyrslovech
        print_string psubq_message, psubq_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
