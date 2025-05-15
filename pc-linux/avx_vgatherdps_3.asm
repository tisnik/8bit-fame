[bits 32]
 
%include "linux_macros.asm"

EOL equ 10

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message
 
align 32
mask      times 8 dd -1     ; 8x maska
indices   dd 8, 9, 10, 11, 12, 13, 14, 15
avx_val_1 dd 0x11111111, 0x22222222, 0x33333333, 0x44444444
          dd 0x55555555, 0x66666666, 0x77777777, 0x88888888

;-----------------------------------------------------------------------------
section .bss
avx_tmp resb 32

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        vzeroall                     ; vynulovat registry

        mov ebx, avx_val_1           ; adresa vektoru s puvodnimi hodnotami
        vmovdqu ymm1, [ebx]          ; nacteni puvodniho vektoru do registru YMM1
        print_avx_reg_as_hex ymm1    ; tisk hodnoty registru YMM1

        mov ebx, mask                ; adresa vektoru s maskami
        vmovdqu ymm3, [ebx]          ; nacteni puvodniho vektoru do registru YMM3
        print_avx_reg_as_hex ymm3    ; tisk hodnoty registru YMM3

        mov ebx, indices             ; adresa vektoru s indexy
        vmovdqu ymm2, [ebx]          ; nacteni puvodniho vektoru do registru YMM2
        print_avx_reg_as_hex ymm2    ; tisk hodnoty registru YMM2

        mov ebx, avx_val_1           ; adresa vektoru
	vgatherdps ymm1, [ebx+ymm2], ymm3
        print_avx_reg_as_hex ymm1    ; tisk hodnoty registru YMM1

        exit                         ; ukonceni procesu


%include "hex2string.asm"
