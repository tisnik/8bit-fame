; Instrukcni soubor mikroprocesoru Intel 8088 a Intel 8086
;
;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 8086        ; specifikace pouziteho instrukcniho souboru

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
        print message

        push cs
        pop  es   ; ES:DI obsahuje adresu prvniho znaku ve zprave
        mov  di, message

        push cs
        pop  ds   ; DS:SI obsahuje adresu prvniho znaku ve zprave
        mov  si, replacement

        mov  cx, 12 ; pocet prepisovanych znaku
        rep movsb   ; precteni znaku a posun adresy
                    ; zapis znaku a posun adresy

        print message

        wait_key
        exit

        ; retezec ukonceny znakem $
        ; (tato data jsou soucasti vysledneho souboru typu COM)
message     db "Hello, world!", 0x0d, 0x0a, "$"
replacement db "Zdravim svet"
