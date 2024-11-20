; Vykresleni pixelu, varianta bez nasobeni. Korektni maskovani.
; Pixely se prekresli pres obrazek.
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; 
; Hrátky s barvovou paletou a vykreslení jednotlivých pixelů kartou CGA
; https://www.root.cz/clanky/hratky-s-barvovou-paletou-a-vykresleni-jednotlivych-pixelu-kartou-cga/
;
;
; preklad pomoci:
;     nasm -f bin -o gfx_6.com gfx_6_putpixel_5.asm
;
; nebo pouze:
;     nasm -o gfx_6.com gfx_6_putpixel_5.asm

;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 8086        ; specifikace pouziteho instrukcniho souboru


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
        gfx_mode 6      ; nastaveni grafickeho rezimu 320x200 se ctyrmi barvami

        mov ax, cs
        mov ds, ax
        mov si, image   ; nyni DS:SI obsahuje adresu prvniho bajtu v obrazku

        mov ax, 0xb800
        mov es, ax
        mov di, 0       ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        call move_half_image

        mov si, image+80; adresa prvniho pixelu na DRUHEM radku
        mov di, 8192    ; druha "stranka" video RAM
        call move_half_image

        mov ax, 0
opak:
        mov bx, ax      ; y-ová souřadnice
        push ax
        add ax, 30
        call putpixel   ; vykreslení pixelu
        pop ax
        inc ax          ; pusun x+=1, y+=1
        cmp ax, 200     ; hranice obrazovky?
        jne opak        ; ne-opakujeme

        wait_key        ; cekat na klavesu
        exit            ; navrat do DOSu


; Vykresleni pixelu
; AX - x-ova souradnice
; BX - y-ova souradnice (staci len BL)
putpixel:
        mov dx, 0xb800     ; zacatek prvni stranky Video RAM
        test bx, 1         ; test, zda se jedna o sudy nebo lichy radek na obrazovce
        jz odd_line
        add dx, 8192/16
odd_line:
        mov es, dx         ; nyni obsahuje ES bud prvni stranku Video RAM nebo stranku druhou

        mov cl, al
        and cl, 7          ; pouze spodni 3 bity x-ove souradnice

        shr ax, 1
        shr ax, 1
        shr ax, 1          ; x/8
        mov di, ax         ; horizontalni posun pocitany v bajtech

        mov ax, bx         ; y-ova souradnice
        and al, 0xfe       ; nejnizsi bit urcuje lichy/sudy radek -> nyni ignorovat
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


move_half_image:
        mov bl, 100     ; pocitadlo radku
outer_loop:
        mov cx, 80/2    ; velikost bloku ve slovech
        rep movsw       ; prenest jeden obrazovy radek
        add si, 80      ; preskocit lichy/sudy radek
        dec bl
        jnz outer_loop  ; opakovat smycku BL-krat
        ret


image:
    incbin "image.bin"
