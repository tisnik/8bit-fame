; Textovy rezim karty VGA.
; Zmena vyznamu nejvyssiho bitu atributu.
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
;     nasm -f bin -o vga.com vga_text_mode_intensity_1.asm
;
; nebo pouze:
;     nasm -o vga.com vga_text_mode_intensity_1.asm


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
        gfx_mode 3      ; nastaveni standardniho textoveho rezimu 80x25 znaku

        mov ax, 0xb800  ; video RAM v textovem rezimu
        mov es, ax
        mov di, 0       ; nyni ES:DI obsahuje adresu prvniho znaku ve video RAM

        mov cx, 80*25   ; pocet zapisovanych znaku
        mov al, 0       ; kod zapisovaneho znaku
opak:
        stosb           ; zapis znaku + atributu
        stosb
        inc al          ; dalsi znak/atribut
        loop opak       ; opakujeme CX-krat

        wait_key

        mov dx, 0x3da
        in  al, dx      ; reset interniho klopneho obvodu

        mov dx, 0x3c0
        mov al, 0x30    ; cislo registru
        out dx, al

        xor al, al      ; zapisovana data
        out dx,al       ; poslat do VGA

        wait_key        ; cekani na klavesu

        exit            ; navrat do DOSu
