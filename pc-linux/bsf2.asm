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

;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:

        xor     ecx, ecx             ; pocitadlo

repeat:
        bsf     edx, ecx             ; zjisteni indexu prvniho nenuloveho bitu

        push    ecx
        mov     ebx, hex_message     ; buffer, ktery se zaplni hexa cislicemi
        call    hex2string           ; zavolani prislusne subrutiny
        print_string   hex_message, hex_message_length    ; tisk hexadecimalni hodnoty
        pop     ecx
        inc     ecx                  ; zvysit hodnotu pocitadla
        cmp     ecx, 17              ; test na konec pocitane smycky
        jne     repeat               ; for-loop

        exit                         ; ukonceni procesu


%include "hex2string.asm"
