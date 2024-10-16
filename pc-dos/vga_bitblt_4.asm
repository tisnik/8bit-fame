; Graficky rezim karty VGA s rozlisenim 640x480 pixelu.
; Zmena barvovych rovin, do kterych se zapisuje.
; Vykresleni barevnych usecek.
; Prenos casti obrazu operaci typu BitBLT - nyni jiz korektni.
; Vyber bitovych rovin pro zapis.
; Vyber bitove roviny pro cteni.
;
; preklad pomoci:
;     nasm -f bin -o vga.com vga_bitblt_4.asm
;
; nebo pouze:
;     nasm -o vga.com vga_bitblt_4.asm


;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 8086        ; specifikace pouziteho instrukcniho souboru

;-----------------------------------------------------------------------------

; I/O porty karty EGA/VGA
GRAPHICS_REGISTER    equ 0x3ce
SEQUENCER_INDEX      equ 0x3c4
SEQUENCER_DATA       equ 0x3c5

; registry karty EGA/VGA
BITPLANE_SELECTOR    equ 0x02   ; sequencer
READ_MAP_SELECT      equ 0x04   ; graphics register


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

; vyber bitove roviny nebo bitovych rovin pro zapis
%macro select_bitplanes_for_write 1
        mov  al, %1         ; bitova rovina
        mov  dx, SEQUENCER_INDEX
        mov  ah, BITPLANE_SELECTOR
        xchg ah, al
        out  dx, ax         ; vyber registru sekvenceru
                            ; a zapis masky bitovych rovin
%endmacro

; vyber bitove roviny pro cteni
%macro select_bitplane_for_read 1
        mov  dx, GRAPHICS_REGISTER
        mov  al, READ_MAP_SELECT
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


        select_bitplane_for_read 0    ; vyber prvni bitove roviny pro cteni
        select_bitplanes_for_write 1  ; vyber prvni bitove roviny pro zapis
        call bitblt                   ; prenos bloku
        wait_key                      ; cekani na klavesu

        select_bitplane_for_read 1    ; vyber druhe bitove roviny pro cteni
        select_bitplanes_for_write 2  ; vyber druhe bitove roviny pro zapis
        call bitblt                   ; prenos bloku
        wait_key                      ; cekani na klavesu

        select_bitplane_for_read 2    ; vyber treti bitove roviny pro cteni
        select_bitplanes_for_write 4  ; vyber treti bitove roviny pro zapis
        call bitblt                   ; prenos bloku
        wait_key                      ; cekani na klavesu

        select_bitplane_for_read 3    ; vyber ctvrte bitove roviny pro cteni
        select_bitplanes_for_write 8  ; vyber ctvrte bitove roviny pro zapis
        call bitblt                   ; prenos bloku
        wait_key                      ; cekani na klavesu

        exit                  ; navrat do DOSu


; operace BitBLT z prvni poloviny obrazovky na druhou polovinu
bitblt:
        mov ax, 0xa000      ; video RAM v textovem rezimu
        mov es, ax
        mov ds, ax
        mov di, 640*240/8   ; nyni ES:DI obsahuje adresu pixelu ve video RAM na 240 radku
        xor si, si          ; nyni DS:SI obsahuje adresu prvniho pixelu ve video RAM

        mov cx, 640*240/8   ; pocet prenesenych bajtu
        rep movsb           ; blokovy prenos po bajtech
        ret                 ; hotovo


draw_color_lines:
        mov ax, 0xa000      ; video RAM v textovem rezimu
        mov es, ax
        xor di, di          ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        mov ax, 0
.opak:
        mov bx, ax          ; y-ová souřadnice

        push ax
        mov cl, 15          ; barva
        call putpixel       ; vykreslení pixelu
        pop ax

        push ax
        mov cl,  7          ; barva
        add ax, 10          ; horizontalni posun useky
        call putpixel       ; vykreslení pixelu
        pop ax

        push ax
        mov cl,  1          ; barva
        add ax, 20          ; horizontalni posun useky
        call putpixel       ; vykreslení pixelu
        pop ax

        push ax
        mov cl,  2          ; barva
        add ax, 30          ; horizontalni posun useky
        call putpixel       ; vykreslení pixelu
        pop ax

        push ax
        mov cl,  4          ; barva
        add ax, 40          ; horizontalni posun useky
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
        select_bitplanes_for_write al
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

        ret                ; hotovo
