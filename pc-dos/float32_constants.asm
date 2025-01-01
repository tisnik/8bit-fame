;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------

org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        jmp main             ; skok na zacatek kodu

%include "io.asm"            ; nacist symboly, makra a podprogramy
%include "print.asm"         ; nacist symboly, makra a podprogramy

main:
        fldz                 ; nacteni FP konstanty 0.0
	print_float32_as_hex ; zobrazeni FP hodnoty v hexadecimalnim tvaru

        fld1                 ; nacteni FP konstanty 1.0
	print_float32_as_hex ; zobrazeni FP hodnoty v hexadecimalnim tvaru

        fldpi                ; nacteni FP konstanty Pi
	print_float32_as_hex ; zobrazeni FP hodnoty v hexadecimalnim tvaru

        wait_key             ; cekani na klavesu
        exit                 ; navrat do DOSu

