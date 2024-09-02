; Graficky rezim karty VGA s rozlisenim 640x480 pixelu.
; Zmena barvovych rovin, do kterych se zapisuje.
; Vykresleni barevnych usecek.
; Prekresleni s vyuzitim logickeho rezimu.
;
; preklad pomoci:
;     nasm -f bin -o vga.com vga_write_mode_3.asm
;
; nebo pouze:
;     nasm -o vga.com vga_write_mode_3.asm


;-----------------------------------------------------------------------------

; I/O porty karty EGA/VGA
GRAPHICS_REGISTER    equ 0x3ce
SEQUENCER_INDEX      equ 0x3c4
SEQUENCER_DATA       equ 0x3c5

; registry karty EGA/VGA
BITPLANE_SELECTOR    equ 0x02   ; sequencer
DATA_ROTATE          equ 0x03   ; graphics register
GRAPHICS_MODE        equ 0x05   ; graphics register


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

; vyber bitove roviny
%macro select_bitplane 1
        mov  al, %1         ; bitova rovina
        mov  dx, SEQUENCER_INDEX
        mov  ah, BITPLANE_SELECTOR
        xchg ah, al
        out  dx, ax         ; vyber registru sekvenceru
                            ; a zapis masky bitovych rovin
%endmacro

; nastaveni logickeho rezimu pri zapisu
%macro write_logic_mode 1
        mov  dx, GRAPHICS_REGISTER
        mov  al, DATA_ROTATE
        out  dx, al         ; vyber VGA registru pro zapis
        inc  dx,
        mov  al, %1         ; zmena VGA registru
        out  dx, al
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        gfx_mode 0x12         ; nastaveni rezimu 640x480 se sestnacti barvami
        call draw_color_lines
        wait_key              ; cekani na klavesu

        mov ax, 0xa000        ; video RAM v textovem rezimu
        mov es, ax
        mov ds, ax
        xor si, si            ; nyni DS:SI obsahuje adresu prvniho pixelu ve video RAM
        xor di, di            ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        write_logic_mode 0b00110000  ; rezim XOR

        select_bitplane 0     ; vyber bitove roviny nebo bitovych rovin
        call fill_screen_area ; vypln casti obrazovky

        select_bitplane 1     ; vyber bitove roviny nebo bitovych rovin
        call fill_screen_area ; vypln casti obrazovky

        select_bitplane 7     ; vyber bitove roviny nebo bitovych rovin
        call fill_screen_area ; vypln casti obrazovky

        select_bitplane 8     ; vyber bitove roviny nebo bitovych rovin
        call fill_screen_area ; vypln casti obrazovky

        select_bitplane 15    ; vyber bitove roviny nebo bitovych rovin
        call fill_screen_area ; vypln casti obrazovky

        wait_key              ; cekani na klavesu
        exit                  ; navrat do DOSu


; vyplneni casti obrazovky
fill_screen_area:
        mov cx, 640*100/8   ; pocet zapisu
.loop:
        lodsb               ; precteni hodnoty do latche
        mov al, 0xf0        ; zapisovany vzorek
        stosb               ; provest vyplneni casti obrazovky
        loop .loop
        ret                 ; hotovo


draw_color_lines:
        mov ax, 0xa000      ; video RAM v textovem rezimu
        mov es, ax
        xor di, di          ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        mov ax, 0
.opak:
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
        cmp ax, 480         ; hranice obrazovky?
        jne .opak           ; ne-opakujeme
        ret                 ; hotovo


; Vykresleni pixelu
; AX - x-ova souradnice
; BX - y-ova souradnice
; CL - barva
putpixel:
        push ax
        mov al, cl         ; vyber bitove roviny nebo bitovych rovin
        select_bitplane al
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
