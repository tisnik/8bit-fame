; Textovy rezim karty VGA s rozlisenim 80x25 znaku.
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
;     nasm -f bin -o vga.com vga_text_mode_80x25.asm
;
; nebo pouze:
;     nasm -o vga.com vga_text_mode_80x25.asm


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

        mov dx, 0x3d8   ; port s rizenim graficke palety
        mov al, 0x18    ; pozadi neblika, meni se intenzita
        out dx, al      ; pres port 0x3d9

        wait_key

        mov dx, 0x3d8   ; port s rizenim graficke palety
        mov al, 0x38    ; pozadi opet blika, nizka intenzita
        out dx, al      ; pres port 0x3d9

        wait_key

        wait_key        ; cekani na klavesu
        exit            ; navrat do DOSu
