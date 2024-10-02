; "Zobrazeni" znaku Bell
;
;
; preklad pomoci:
;     nasm -f bin -o sound_bell.com sound_bell.asm
;
; nebo pouze:
;     nasm -o sound_bell.com sound_bell.asm

 
;-----------------------------------------------------------------------------

; ukonceni procesu a navrat do DOSu
%macro exit 0
        ret
%endmacro

; vyprazdneni bufferu klavesnice a cekani na klavesu
%macro wait_key 0
        xor     ax, ax
        int     0x16
%endmacro

; tisk retezce na obrazovku
%macro print 1
        mov     dx, %1
        mov     ah, 9
        int     0x21
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        print message_with_beep
        wait_key
        exit

        ; retezec ukonceny znakem $
        ; (tato data jsou soucasti vysledneho souboru typu COM)
message_with_beep db "Hello, ", 0x07, "world!", 0x0d, 0x0a, "$"
