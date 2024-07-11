; Textovy rezim karty CGA.
; Zmena tvaru textoveho kurzoru.
;
; preklad pomoci:
;     nasm -f bin -o gfx_text.com cga_text_mode_cursor.asm
;
; nebo pouze:
;     nasm -o gfx_text.com cga_text_mode_cursor.asm


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
