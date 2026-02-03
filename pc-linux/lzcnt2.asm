[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
	 db 0x0a
         hex_message_length equ $ - hex_message

;-----------------------------------------------------------------------------
section .bss

id_string: resb 8

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
	mov     eax, 0x42            ; == 0b04000010
	rep bsr   edx, eax

        mov     ebx, hex_message     ; buffer, ktery se zaplni hexa cislicemi
        call    hex2string           ; zavolani prislusne subrutiny
        print_string   hex_message, hex_message_length    ; tisk hexadecimalni hodnoty

        exit                         ; ukonceni procesu


%include "hex2string.asm"
