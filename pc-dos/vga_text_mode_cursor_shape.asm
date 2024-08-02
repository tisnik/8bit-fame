; Textovy rezim karty VGA s rozlisenim 80x25 znaku.
; Zmena tvaru textoveho kurzoru.
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu.
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Od EGA ke grafickým kartám MCGA a VGA
; https://www.root.cz/clanky/od-ega-ke-grafickym-kartam-mcga-a-vga/#k19
;
;
; preklad pomoci:
;     nasm -f bin -o vga.com vga_text_mode_cursor_shape.asm
;
; nebo pouze:
;     nasm -o vga.com vga_text_mode_cursor_shape.asm


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

%macro set_crtc_register 2
        mov dx, 0x3d4
        mov al, %1      ; vyber registru
        out dx, al
        inc dx
        mov al, %2      ; zapisovana hodnota
        out dx, al
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        gfx_mode 3      ; nastaveni standardniho textoveho rezimu 80x25 znaku

        mov ax, 0xb800  ; video RAM v textovem rezimu
        mov es, ax
        mov di, 0       ; nyni ES:DI obsahuje adresu prvniho znaku ve video RAM

        mov cx, 95      ; pocet zapisovanych znaku
        mov al, 32      ; kod zapisovaneho znaku
opak:
        stosb           ; zapis znaku
        inc al          ; dalsi znak
        inc di          ; preskocit atribut
        loop opak       ; opakujeme CX-krat

        wait_key        ; cekani na klavesu

        set_crtc_register 0x0a, 0
        wait_key        ; cekani na klavesu

        set_crtc_register 0x0b, 3
        wait_key        ; cekani na klavesu

        exit            ; navrat do DOSu
