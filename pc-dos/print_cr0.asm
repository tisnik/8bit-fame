; Tisk obsahu specialniho registru CR0.
; Kompatibilni s cipem Intel 80286
;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU  386        ; specifikace pouziteho instrukcniho souboru

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
org  0x100                     ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
    mov  eax, cr0              ; prenos CR0 do registru EAX
    shr  eax, 24               ; hornich 8 bitu do AL
    print_hex al

    mov  eax, cr0              ; prenos CR0 do registru EAX
    shr  eax, 16               ; bity 16-23 do AL
    print_hex al

    mov  eax, cr0              ; prenos CR0 do registru EAX
    mov  al, ah                ; bity 8-15 do AL
    print_hex al

    mov  eax, cr0              ; prenos CR0 do registru EAX
    print_hex al               ; tisk spodnich osmi bitu

    wait_key                   ; cekani na stisk klavesy
    exit                       ; navrat do DOSu

; datova cast

        ; retezec ukonceny znakem $
        ; (tato data jsou soucasti vysledneho souboru typu COM)
message db 0x01, 0x01, "$"

        ; prevodni tabulka hodnoty 0-15 na ASCII znak
hex_digits db "0123456789abcdef"