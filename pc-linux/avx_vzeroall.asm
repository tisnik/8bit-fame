[bits 32]
 
%include "linux_macros.asm"

SPACE equ 32
EOL equ 10

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message
 
align 32
avx_val_1 db  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16
          db 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32
avx_val_2 times 32 db 0xff

;-----------------------------------------------------------------------------
section .bss
avx_tmp resb 32

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        mov ebx, avx_val_1           ; adresa vektoru
        vmovdqu ymm0, [ebx]          ; nacteni puvodniho vektoru do registru YMM0
        print_avx_reg_as_hex ymm0    ; tisk hodnoty registru YMM0

        mov ebx, avx_val_2           ; adresa vektoru
        vmovdqu ymm1, [ebx]          ; nacteni puvodniho vektoru do registru YMM1
        print_avx_reg_as_hex ymm1    ; tisk hodnoty registru YMM1

        vzeroall                     ; vynulování všech prvků registrů
        print_avx_reg_as_hex ymm0    ; tisk hodnoty registru YMM0
        print_avx_reg_as_hex ymm1    ; tisk hodnoty registru YMM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
