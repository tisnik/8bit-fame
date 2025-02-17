[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
	 db ' '
	 hex_message_length equ $ - hex_message
 
punpcklwd_message:
         db 0x0a, "punpcklwd:", 0x0a
	 punpcklwd_message_length equ $ - punpcklwd_message
 
punpckhwd_message:
         db 0x0a, "punpckhwd:", 0x0a
	 punpckhwd_message_length equ $ - punpckhwd_message
 
 
 
mmx_val_1 dw 0x0000, 0x1111, 0x2222, 0x3333
mmx_val_2 dw 0x4444, 0x5555, 0x6666, 0x7777

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

        movq mm3, mm1                ; zapamatovat si hodnotu pro další použití
        movq mm4, mm2                ; zapamatovat si hodnotu pro další použití

	punpcklwd mm1, mm2           ; zkombinovani obsahu dvou vektoru
        print_string punpcklwd_message, punpcklwd_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        movq mm1, mm3                ; obnovit hodnotu registru mm1
        movq mm2, mm4                ; obnovit hodnotu registru mm2
	punpckhwd mm1, mm2           ; zkombinovani obsahu dvou vektoru
        print_string punpckhwd_message, punpckhwd_message_length
	print_mmx_reg_as_hex mm1     ; tisk hodnoty registru MM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
