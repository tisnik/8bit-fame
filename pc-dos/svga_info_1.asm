;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        jmp main                   ; skok na zacatek kodu

%include "io.asm"                  ; nacist symboly, makra a podprogramy
%include "print.asm"               ; nacist symboly, makra a podprogramy

main:
        push ds
        pop  es                    ; nastaveni CS=DS=ES

        clc                        ; ziskani zakladnich informaci o VESA rezimech
        mov  di, vesa_block_info
        mov ax, 0x4f00
        int     0x10

        cmp ax, 0x004f             ; test, zda bylo volani funkce BIOSu uspesne
        jne     failed

success:
        print_string success_msg
        jmp     finish

failed:
        print_string failed_msg

finish:
        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu


; datova cast
section .data

success_msg: db "Success", 0x0a, 0x0d, "$"
failed_msg:  db "Failed", 0x0a, 0x0d, "$"

section .bss
vesa_block_info: resb 512


