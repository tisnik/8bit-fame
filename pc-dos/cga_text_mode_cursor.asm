; Textovy rezim karty CGA.
; Zmena tvaru textoveho kurzoru.
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Textové režimy grafické karty CGA a řadič displeje Motorola 6845
; https://www.root.cz/clanky/textove-rezimy-graficke-karty-cga-a-radic-displeje-motorola-6845/
;
;
; preklad pomoci:
;     nasm -f bin -o gfx_text.com cga_text_mode_cursor.asm
;
; nebo pouze:
;     nasm -o gfx_text.com cga_text_mode_cursor.asm

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
        gfx_mode 3      ; nastaveni textoveho rezimu 80x25 znaku

        mov ax, 0xb800
        mov es, ax
        mov di, 0       ; nyni ES:DI obsahuje adresu prvniho znaku ve video RAM

        wait_key

        mov dx, 0x3d4
        mov al, 0x0a    ; registr s ovladanim tvaru textoveho kurzoru
        out dx, al
        mov dx, 0x3d5
        mov al, 0       ; scanline, kde kurzor zacina 
        out dx, al

        mov dx, 0x3d4
        mov al, 0x0b    ; registr s ovladanim tvaru textoveho kurzoru
        out dx, al
        mov dx, 0x3d5
        mov al, 5       ; scanline, kde kurzor konci
        out dx, al

        wait_key

        exit
