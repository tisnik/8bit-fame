; Vykresleni pixelu tou nejpomalejsi cestou - pres funkci BIOSu
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
;     nasm -f bin -o gfx_4.com gfx_4_putpixel.asm
;
; nebo pouze:
;     nasm -o gfx_4.com gfx_4_putpixel.asm


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

; vykresleni pixelu pres BIOS
%macro put_pixel 3
        mov     ah, 0xc   ; cislo sluzby BIOSu
        xor     bx, bx    ; cislo stranky
        mov     cx, %1    ; sloupec (X)
        mov     dx, %2    ; radek (Y)
        mov     al, %3    ; barva pixelu
        int     0x10      ; vykresleni pixelu pres BIOS
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        gfx_mode 4             ; nastaveni grafickeho rezimu 320x200 se ctyrmi barvami
        put_pixel 160, 100, 1  ; volani makra se tremi parametry
        wait_key               ; cekani na stisk klavesy
        exit                   ; a navrat do DOSu
