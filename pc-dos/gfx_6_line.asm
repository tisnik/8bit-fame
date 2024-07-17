; Vykresleni usecky tou nejpomalejsi cestou - pres funkci BIOSu
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu.
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Vývoj her a grafických dem pro oslavovanou i nenáviděnou platformu PC (vražedná kombinace 8088 a CGA)
; https://www.root.cz/clanky/vyvoj-her-a-grafickych-dem-pro-oslavovanou-i-nenavidenou-platformu-pc-vrazedna-kombinace-8088-a-cga/#k19
;
;
; preklad pomoci:
;     nasm -f bin -o gfx_6.com gfx_6_putpixel.asm
;
; nebo pouze:
;     nasm -o gfx_6.com gfx_6_putpixel.asm


;-----------------------------------------------------------------------------

; ukonceni procesu a navrat do DOSu
%macro exit 0
        mov     ah, 0x4c
        int     0x21
%endmacro

; vyprazdneni bufferu klavesnice a cekani na klavesu
%macro wait_key 0
        xor     ax, ax
        int     0x16
%endmacro

; nastaveni grafickeho rezimu
%macro gfx_mode 1
        mov     ah, 0
        mov     al, %1
        int     0x10
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        gfx_mode 6        ; nastaveni grafickeho rezimu 640x200 se 2 barvami

        mov     ah, 0xc   ; cislo sluzby BIOSu
        mov     al, 1     ; barva pixelu
        xor     bx, bx    ; cislo stranky
        mov     cx, 0     ; sloupec
        mov     dx, 0     ; radek
opak:
        int     0x10      ; vykresleni pixelu pres BIOS
        inc     cx        ; x+=1
        inc     dx        ; y+=1
        cmp     cx, 200   ; kontrola, zda jsme dosahli posledni souradnice
        jne     opak      ; pokud ne, dalsi iterace

        wait_key          ; cekani na stisk klavesy
        exit              ; a navrat do DOSu
