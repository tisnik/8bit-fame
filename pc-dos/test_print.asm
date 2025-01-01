;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        jmp main            ; skok na zacatek kodu

%include "io.asm"           ; nacist symboly, makra a podprogramy
%include "print.asm"        ; nacist symboly, makra a podprogramy

main:
        print_hex 0x12345678
        print_hex 0xcafebabe
        print_dec 123456789

        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu
