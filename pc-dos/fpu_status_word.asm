; Precteni stavoveho slova matematickeho koprocesoru
;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS

;-----------------------------------------------------------------------------

org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        jmp main                   ; skok na zacatek kodu

%include "io.asm"                  ; nacist symboly, makra a podprogramy
%include "print.asm"               ; nacist symboly, makra a podprogramy

main:
        fninit                     ; inicializace koprocesoru
        fnstsw word [test_word]    ; ulozeni stavoveho slova
	mov ax, word [test_word]
	print_hex_16 ax            ; tisk stavoveho slova v hexadecimalnim formatu

        wait_key                   ; cekani na klavesu
        exit                       ; navrat do DOSu

;-----------------------------------------------------------------------------

; datova cast
test_word: dw 0
