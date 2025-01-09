;-----------------------------------------------------------------------------
; Symboly, makra a subrutiny pro tisk hodnot na standardni vystup
;-----------------------------------------------------------------------------

%ifndef PRINT_LIB
%define PRINT_LIB


;-----------------------------------------------------------------------------
; makra
;-----------------------------------------------------------------------------

; makro pro tisk retezce na obrazovku
%macro print_string 1
        mov     dx, %1
        mov     ah, 9
        int     0x21
%endmacro

; makro pro tisk 32bitove hexadecimalni hodnoty
; na standardni vystup
%macro print_hex 1
        pusha                         ; uchovat vsechny registry
        mov     edx, %1               ; zapamatovat si hodnotu pro tisk
        mov     ebx, hex_message      ; buffer, ktery se zaplni hexa cislicemi
        call    hex2string            ; zavolani prislusne subrutiny
        print_string   hex_message    ; tisk hexadecimalni hodnoty
        popa                          ; obnovit vsechny registry
%endmacro

; makro pro vypis 32bitove desitkove hodnoty na standardni vystup
%macro print_dec 1
        pusha                         ; uschovat vsechny registry na zasobnik
        mov     eax, %1               ; hodnotu pro tisk ulozit do registru EAX
        mov     ebx, dec_message      ; buffer, ktery se zaplni desitkovymi cisticemi
        call    decimal2string        ; zavolani prislusne subrutiny pro prevod na string
        print_string   dec_message    ; tisk hexadecimalni hodnoty
        popa                          ; obnovit vsechny registry
%endmacro

; makro pro vypis obsahu FP hodnoty z vrcholu zasobniku ve forme hexadecimalniho cisla
%macro print_float32_as_hex 0
        fstp dword [float32] ; ulozeni do pameti (4 bajty)
        mov  eax, [float32]  ; nacteni FP hodnoty do celociselneho registru
        print_hex eax        ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
%endmacro

; makro pro vypis obsahu FP hodnoty z vrcholu zasobniku ve forme hexadecimalniho cisla
%macro print_float64_as_hex 0
        fstp qword [float64] ; ulozeni do pameti (8 bajtu)
        mov  eax, [float64+4]; nacteni FP hodnoty do celociselneho registru
        print_hex eax        ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
        mov  eax, [float64]  ; nacteni FP hodnoty do celociselneho registru
        print_hex eax        ; zobrazeni obsahu tohoto registru v hexadecimalnim tvaru
%endmacro


;-----------------------------------------------------------------------------
; subrutiny
;-----------------------------------------------------------------------------

; subrutina urcena pro prevod 32bitove hexadecimalni hodnoty na retezec
; Vstup: EDX - hodnota, ktera se ma prevest na retezec
;        EBX - adresa jiz drive alokovaneho retezce (resp. osmice bajtu)
hex2string:
                  mov cl,  8                ; pocet opakovani smycky

.print_one_digit: rol edx, 4                ; rotace doleva znamena, ze se do spodnich 4 bitu nasune dalsi cifra
                  mov al, dl                ; nechceme porusit obsah vstupni hodnoty v EDX, proto pouzijeme AL
                  and al, 0x0f              ; maskovani, potrebujeme pracovat jen s jednou cifrou
                  cmp al, 10                ; je cifra vetsi nebo rovna 10?
                  jl  .store_digit          ; neni, pouze prevest 0..9 na ASCII hodnotu '0'..'9'

.alpha_digit:     add al, 'A'-10-'0'        ; prevod hodnoty 10..15 na znaky 'A'..'F'

.store_digit:     add al, '0'
                  mov [ebx], al             ; ulozeni cifry do retezce
                  inc ebx                   ; dalsi ulozeni v retezci o znak dale
                  dec cl                    ; snizeni pocitadla smycky
                  jnz .print_one_digit      ; a opakovani smycky, dokud se nedosahlo nuly

                  ret                       ; navrat ze subrutiny


; subrutina urcena pro prevod 32bitove desitkove hodnoty na retezec
; Vstup: EDX - hodnota, ktera se ma prevest na retezec
;        EBX - adresa jiz drive alokovaneho retezce (resp. minimalne deseti bajtu)
decimal2string:
                  mov ecx, 10              ; celkovy pocet zapisovanych cifer/znaku
                  mov edi, ecx             ; instrukce DIV vyzaduje deleni registrem, pouzijme tedy EDI

.next_digit:
                  xor edx, edx             ; delenec je dvojice EDX:EAX, vynulujeme tedy horni registr EDX
                  div edi                  ; deleni hodnoty ulozene v EDX:EAX deseti (delitelem je EDI)
                                           ; vysledek se ulozi do EAX, zbytek do EDX
                                           ; pri deleni deseti je jistota, ze zbytek je jen cislo 0..9

                  add dl, '0'              ; prevod hodnoty 0..9 na znak '0'-'9'

                  mov [ebx+ecx-1], dl      ; zapis retezce (od posledniho znaku)

                  dec ecx                  ; presun na predchozi znak v retezci a soucasne snizeni hodnoty pocitadla
                  jnz .next_digit          ; uz jsme dosli k poslednimu cislu?

                  ret                      ; navrat ze subrutiny


;-----------------------------------------------------------------------------
; buffery
;-----------------------------------------------------------------------------

        ; retezec ukonceny znakem $
        ; (tato data jsou soucasti vysledneho souboru typu COM)
hex_message:
         times 8 db '?', 
         db 0x0d, 0x0a, "$"

        ; retezec ukonceny znakem $
        ; (tato data jsou soucasti vysledneho souboru typu COM)
dec_message:
         times 10 db '?', 
         db 0x0d, 0x0a, "$"

float32: dd 0
float64: dq 0

%endif
