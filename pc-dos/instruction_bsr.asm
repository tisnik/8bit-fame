; Instrukcni soubor mikroprocesoru Intel 80386.
; Test instrukce BSR.
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 386         ; specifikace pouziteho instrukcniho souboru

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

; tisk hexadecimalni hodnoty
%macro print_hex 1
        mov     bx, hex_digits
        mov     cl, %1                ; zapamatovat si predanou hodnotu

        mov     al, cl                ; do AL se vlozi horni hexa cifra
        and     al, 0xf0
        shr     al, 1
        shr     al, 1
        shr     al, 1
        shr     al, 1

        xlat                          ; prevod hodnoty 0-15 na ASCII znak
        mov     [message], al         ; zapis ASCII znaku do retezce

        mov     al, cl                ; do BL se vlozi dolni hexa cifra
        and     al, 0x0f
        xlat                          ; prevod hodnoty 0-15 na ASCII znak
        mov     [message + 1], al     ; zapis ASCII znaku do retezce

        print   message
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        mov  ebx, 0x00030000 ; nastavení bitu
	bsr  eax, ebx        ; vyhledání prvního nenulového bitu
        print_hex al         ; výsledek je v EAX, ovšem nám stačí jen AL

        wait_key
        exit

        ; retezec ukonceny znakem $
        ; (tato data jsou soucasti vysledneho souboru typu COM)
message db 0x01, 0x01, 0x0d, 0x0a, "$"

        ; prevodni tabulka hodnoty 0-15 na ASCII znak
hex_digits db "0123456789abcdef"