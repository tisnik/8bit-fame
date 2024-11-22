; Textovy rezim karty VGA s rozlisenim 80x50 znaku.
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Od EGA ke grafickým kartám MCGA a VGA
; https://www.root.cz/clanky/od-ega-ke-grafickym-kartam-mcga-a-vga/#k19
;
;
; preklad pomoci:
;     nasm -f bin -o vga.com vga_text_mode_80x50.asm
;
; nebo pouze:
;     nasm -o vga.com vga_text_mode_80x50.asm


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

; nastaveni fontu 8x8 pixelu
%macro set_font_8x8 0
        mov ax, 0x1112
        xor bl, bl
        int 0x10
%endmacro

; nastaveni fontu 8x14 pixelu
%macro set_font_8x14 0
        mov ax, 0x1111
        xor bl, bl
        int 0x10
%endmacro

; nastaveni fontu 8x16 pixelu
%macro set_font_8x16 0
        mov ax, 0x1114
        xor bl, bl
        int 0x10
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        gfx_mode 3      ; nastaveni standardniho textoveho rezimu 80x25 znaku

        mov ax, 0xb800  ; video RAM v textovem rezimu
        mov es, ax
        mov di, 0       ; nyni ES:DI obsahuje adresu prvniho znaku ve video RAM

        mov cx, 80*50   ; pocet zapisovanych znaku
        mov al, 0       ; kod zapisovaneho znaku
opak:
        stosb           ; zapis znaku + atributu
        stosb
        inc al          ; dalsi znak/atribut
        loop opak       ; opakujeme CX-krat

        wait_key        ; cekani na klavesu

        set_font_8x8    ; nastaveni fontu 8x8 pixelu
        wait_key        ; cekani na klavesu

        set_font_8x14   ; nastaveni fontu 8x14 pixelu
        wait_key        ; cekani na klavesu

        set_font_8x16   ; nastaveni fontu 8x16 pixelu
        wait_key        ; cekani na klavesu

        exit            ; navrat do DOSu
