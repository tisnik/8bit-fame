;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; 
; Rozšíření instrukční sady AVX a programy v assembleru
; https://www.root.cz/clanky/rozsireni-instrukcni-sady-avx-a-programy-v-assembleru/

[bits 32]
 
%include "linux_macros.asm"

;-----------------------------------------------------------------------------
section .data

hex_message:
         times 8 db '?'
         db ' '
         hex_message_length equ $ - hex_message
 
align 32
avx_val_1 db 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
          db 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
          db 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 
          db 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 
avx_val_2 db 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
          db 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
          db 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
          db 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 

;-----------------------------------------------------------------------------
section .bss
avx_tmp resb 32

 
;-----------------------------------------------------------------------------
section .text
        global _start                ; tento symbol ma byt dostupny i linkeru

_start:
        mov ebx, avx_val_1           ; adresa prvniho vektoru
        vmovdqu ymm0, [ebx]          ; nacteni puvodniho vektoru do registru YMM0
        print_avx_reg_as_hex ymm0    ; tisk hodnoty registru YMM0

        mov ebx, avx_val_2           ; adresa druheho vektoru
        vmovdqu ymm1, [ebx]          ; nacteni puvodniho vektoru do registru YMM1
        print_avx_reg_as_hex ymm1    ; tisk hodnoty registru YMM1

        vpaddb ymm2, ymm0, ymm1      ; ymm2 = ymm0 + ymm1 (po bajtech)
        print_avx_reg_as_hex ymm2    ; tisk hodnoty registru YMM2

        vpaddw ymm2, ymm0, ymm1      ; ymm2 = ymm0 + ymm1 (po slovech)
        print_avx_reg_as_hex ymm2    ; tisk hodnoty registru YMM2

        vpaddd ymm2, ymm0, ymm1      ; ymm2 = ymm0 + ymm1 (po dvojslovech)
        print_avx_reg_as_hex ymm2    ; tisk hodnoty registru YMM2

        vpaddq ymm2, ymm0, ymm1      ; ymm2 = ymm0 + ymm1 (po ctyrslovech)
        print_avx_reg_as_hex ymm2    ; tisk hodnoty registru YMM2

        exit                         ; ukonceni procesu


%include "hex2string.asm"
