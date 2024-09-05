; Graficky rezim karty EGA s rozlisenim 640x350 pixelu.
; Zmena barvovych rovin, do kterych se zapisuje.
; Vykresleni barevnych usecek.
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Grafická karta EGA: pouze mírný pokrok v mezích zákona (2. část)
; https://www.root.cz/clanky/graficka-karta-ega-pouze-mirny-pokrok-v-mezich-zakona-2-cast/
;
;
; preklad pomoci:
;     nasm -f bin -o ega.com ega_640x350_putpixel.asm
;
; nebo pouze:
;     nasm -o ega.com ega_640x350_putpixel.asm

;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 8086        ; specifikace pouziteho instrukcniho souboru


;-----------------------------------------------------------------------------

; registry karty EGA/VGA
EGA_CONTROLLER    equ 0x3c4
BITPLANE_SELECTOR equ 0x02


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
        gfx_mode 0x10       ; nastaveni rezimu 640x350 se sestnacti barvami
        mov ax, 0xa000      ; video RAM v textovem rezimu
        mov es, ax
        xor di, di          ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        mov ax, 0
opak:
        mov bx, ax          ; y-ová souřadnice

        push ax
        mov cl, 10          ; barva
        call putpixel       ; vykreslení pixelu
        pop ax

        push ax
        mov cl, 11          ; barva
        add ax, 10          ; horizontalni posun useky
        call putpixel       ; vykreslení pixelu
        pop ax

        push ax
        mov cl, 12          ; barva
        add ax, 20          ; horizontalni posun useky
        call putpixel       ; vykreslení pixelu
        pop ax

        inc ax              ; pusun x+=1, y+=1
        cmp ax, 350         ; hranice obrazovky?
        jne opak            ; ne-opakujeme

        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu

select_bitplane:
        mov  dx, EGA_CONTROLLER
        mov  ah, BITPLANE_SELECTOR
        xchg ah, al
        out  dx, ax         ; vyber registru sekvenceru
                            ; a zapis masky bitovych rovin
        ret                 ; hotovo

; Vykresleni pixelu
; AX - x-ova souradnice
; BX - y-ova souradnice (staci len BL)
; CL - barva
putpixel:
        push ax
        mov al, cl         ; vyber bitove roviny nebo bitovych rovin
        call select_bitplane
        pop ax

        mov dx, 0xa000     ; zacatek stranky video RAM
        mov es, dx         ; nyni obsahuje ES stranku video RAM

        mov cl, al
        and cl, 7          ; pouze spodni 3 bity x-ove souradnice

        shr ax, 1
        shr ax, 1
        shr ax, 1          ; x/8
        mov di, ax         ; horizontalni posun pocitany v bajtech

        mov ax, bx         ; y-ova souradnice
        shl ax, 1          ; y*2
        shl ax, 1          ; y*4
        shl ax, 1          ; y*8
        shl ax, 1          ; y*16
        add di, ax         ; pricist cast y-oveho posunu
        shl ax, 1          ; y*32
        shl ax, 1          ; y*64
        add di, ax         ; pricist zbytek y-oveho posunu
                           ; -> y*16 + y*64 = y*80

        mov al, 0x80       ; vypocitat masku pixelu
        shr al, cl
        or [es:di], al     ; vlastni vykresleni pixelu

        ret
