%ifndef HEX_2_STRING_LIB
%define HEX_2_STRING_LIB

; subrutina urcena pro prevod 32bitove hexadecimalni hodnoty na retezec
; Vstup: EDX - hodnota, ktera se ma prevest na retezec
;        EBX - adresa jiz drive alokovaneho retezce (resp. osmice bajtu)
hex2string:
                  mov ecx,  8               ; pocet opakovani smycky

.print_one_digit: rol edx, 4                ; rotace doleva znamena, ze se do spodnich 4 bitu nasune dalsi cifra
                  mov al, dl                ; nechceme porusit obsah vstupni hodnoty v EDX, proto pouzijeme AL
                  and al, 0x0f              ; maskovani, potrebujeme pracovat jen s jednou cifrou
                  cmp al, 10                ; je cifra vetsi nebo rovna 10?
                  jl  .store_digit          ; neni, pouze prevest 0..9 na ASCII hodnotu '0'..'9'

.alpha_digit:     add al, 'A'-10-'0'        ; prevod hodnoty 10..15 na znaky 'A'..'F'

.store_digit:     add al, '0'
                  mov [ebx], al             ; ulozeni cifry do retezce
		  inc ebx                   ; dalsi cifra
		  loop .print_one_digit     ; a opakovani smycky, dokud se nedosahlo nuly

                  ret                       ; navrat ze subrutiny

%endif
