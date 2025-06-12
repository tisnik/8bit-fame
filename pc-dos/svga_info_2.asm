;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
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

        mov eax, [Signature]       ; zkopirovat VESA signaturu do DOSovskeho retezce
        mov [signature_msg], eax
        print_string signature_msg ; tisk naplneneho retezce

        sub eax, eax
        mov ax, [Version]          ; verze VBE
        print_hex eax

        sub eax, eax
        mov ax, [CountOf64KBlocks] ; pocet 64kB bloku video RAM
        print_dec eax

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
signature_msg:   db "????", 0x0a, 0x0d, "$"

section .bss
vesa_block_info:
        Signature               resb 4
        Version                 resw 1
        OEMNamePtr              resd 1
        Capabilities            resd 1

        VideoModesOffset        resw 1
        VideoModesSegment       resw 1

        CountOf64KBlocks        resw 1
        OEMSoftwareRevision     resw 1
        OEMVendorNamePtr        resd 1
        OEMProductNamePtr       resd 1
        OEMProductRevisionPtr   resd 1
        Reserved                resb 222
        OEMData                 resb 256
