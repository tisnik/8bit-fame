; Instrukcni soubor mikroprocesoru Intel 8088 a Intel 8086
;
; Sablona se zakladnimi makry, ktere se pouzivaji i v dalsich prikladech.
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
        wait_key
        exit

        ; retezec ukonceny znakem $
        ; (tato data jsou soucasti vysledneho souboru typu COM)
message db 0x01, 0x01, 0x0d, 0x0a, "$"
