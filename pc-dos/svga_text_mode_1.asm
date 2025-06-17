;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        jmp main                   ; skok na zacatek kodu

%include "io.asm"                  ; nacist symboly, makra a podprogramy
%include "print.asm"               ; nacist symboly, makra a podprogramy




main:
        push ds
        pop  es                    ; nastaveni CS=DS=ES

        mov  bx, 0x108             ; cislo rezimu
        mov  ax, 0x4f02            ; nastaveni grafickeho rezimu
        int      0x10

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

success_msg:     db "Success", 0x0a, 0x0d, "$"
failed_msg:      db "Failed", 0x0a, 0x0d, "$"
