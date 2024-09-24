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

; tisk hexadecimalni hodnoty
%macro print_hex 1
        mov     cl, %1                ; zapamatovat si predanou hodnotu
        xor     bh, bh                ; vynulovat horni bajt offsetu

        mov     bl, cl                ; do BL se vlozi horni hexa cifra
        and     bl, 0xf0
        shr     bl, 1
        shr     bl, 1
        shr     bl, 1
        shr     bl, 1

        mov     al, [hex_digits + bx] ; prevod hodnoty 0-15 na ASCII znak
        mov     [message], al         ; zapis ASCII znaku do retezce

        mov     bl, cl                ; do BL se vlozi dolni hexa cifra
        and     bl, 0x0f
        mov     al, [hex_digits + bx] ; prevod hodnoty 0-15 na ASCII znak
        mov     [message + 1], al     ; zapis ASCII znaku do retezce
        print   message
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        print_hex 0x00
        print_hex 0x12
        print_hex 0xab
        print_hex 0xff
        wait_key
        exit

        ; retezec ukonceny znakem $
        ; (tato data jsou soucasti vysledneho souboru typu COM)
message db 0x01, 0x01, 0x0d, 0x0a, "$"

        ; prevodni tabulka hodnoty 0-15 na ASCII znak
hex_digits db "0123456789abcdef"
