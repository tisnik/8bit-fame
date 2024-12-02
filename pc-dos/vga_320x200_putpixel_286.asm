; Graficky rezim karty VGA s rozlisenim 320x200 pixelu.
; Pouziti predpocitane tabulky.
; Vykresleni barevnych usecek.
; Urceno pro 80286 a vyssi.
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; preklad pomoci:
;     nasm -f bin -o vga.com vga_320x200_putpixel_286.asm
;
; nebo pouze:
;     nasm -o vga.com vga_320x200_putpixel_286.asm



;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 286         ; specifikace pouziteho instrukcniho souboru

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
        gfx_mode 0x13       ; nastaveni rezimu 320x200 s 256 barvami
        push 0xa000         ; video RAM v textovem rezimu
        pop  es
        xor di, di          ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        mov ax, 0
opak:
        mov bx, ax          ; y-ová souřadnice

        push ax
        mov cl, al          ; barva
        call putpixel       ; vykreslení pixelu
        pop ax

        push ax
        mov cl, al          ; barva
        add ax, 10          ; horizontalni posun useky
        call putpixel       ; vykreslení pixelu
        pop ax

        push ax
        mov cl, al          ; barva
        add ax, 20          ; horizontalni posun useky
        call putpixel       ; vykreslení pixelu
        pop ax

        inc ax              ; pusun x+=1, y+=1
        cmp ax, 200         ; hranice obrazovky?
        jne opak            ; ne-opakujeme

        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu

; Vykresleni pixelu
; AX - x-ova souradnice
; BX - y-ova souradnice (staci len BL)
; CL - barva
putpixel:
        mov dx, 0xa000     ; zacatek stranky video RAM
        mov es, dx         ; nyni obsahuje ES stranku video RAM

        mov di, ax         ; horizontalni posun pocitany v bajtech

        mov ax, bx         ; y-ova souradnice
        shl ax, 6          ; y*64
        add di, ax         ; pricist cast y-oveho posunu
        shl ax, 2          ; y*256
        add di, ax         ; pricist zbytek y-oveho posunu
                           ; -> y*64 + y*256 = y*320

        mov [es:di], cl     ; vlastni vykresleni pixelu

        ret
