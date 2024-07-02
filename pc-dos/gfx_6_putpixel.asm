; Vykresleni pixelu tou nejpomalejsi cestou - pres funkci BIOSu
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

; vykresleni pixelu pres BIOS
%macro put_pixel 3
        mov     ah, 0xc
        xor     bx, bx    ; cislo stranky
        mov     cx, %1    ; sloupec (X)
        mov     dx, %2    ; radek (Y)
        mov     al, %3    ; barva pixelu
        int     0x10
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        gfx_mode 6
        put_pixel 320, 100, 1
        wait_key
        exit
