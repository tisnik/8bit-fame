[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db 0x0a
         hex_message_length equ $ - hex_message

zf_set_message:
         db "ZF set   "
         zf_set_message_length equ $ - zf_set_message

zf_reset_message:
         db "ZF reset "
         zf_reset_message_length equ $ - zf_reset_message

;-----------------------------------------------------------------------------
section .bss

;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:

        xor     ecx, ecx             ; pocitadlo

repeat:
        bsf     edx, ecx             ; zjisteni indexu prvniho nenuloveho bitu
        push    ecx
        push    edx

        jnz     zf_reset

zf_set:
        print_string   zf_set_message, zf_set_message_length
        jmp     continue

zf_reset:
        print_string   zf_reset_message, zf_reset_message_length

continue:
        pop     edx

        mov     ebx, hex_message     ; buffer, ktery se zaplni hexa cislicemi
        call    hex2string           ; zavolani prislusne subrutiny
        print_string   hex_message, hex_message_length    ; tisk hexadecimalni hodnoty
        pop     ecx
        inc     ecx                  ; zvysit hodnotu pocitadla
        cmp     ecx, 17              ; test na konec pocitane smycky
        jne     repeat               ; for-loop

        exit                         ; ukonceni procesu


%include "hex2string.asm"
