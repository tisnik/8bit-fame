; Textovy rezim karty VGA.
; Zmena vyznamu devateho sloupce u znaku.
;
;
; preklad pomoci:
;     nasm -f bin -o vga.com vga_text_mode_9th_column.asm
;
; nebo pouze:
;     nasm -o vga.com vga_text_mode_9th_column.asm


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

        mov cx, 45      ; pocet zapisovanych znaku
        mov al, 179     ; kod zapisovaneho znaku
opak:
        stosb           ; zapis znaku
        inc al          ; dalsi znak
        inc di          ; preskocit atribut
        loop opak       ; opakujeme CX-krat

        wait_key

        mov dx, 0x3da
        in  al, dx      ; reset interniho klopneho obvodu

        mov dx, 0x3c0
        mov al, 0x30    ; cislo registru
        out dx, al

        inc  dx         ; cteni obsahu registru
        in   al,dx
        and  al,(~(1<<2)) ; vymaskovani tretiho bitu
        dec  dx
        out dx,al       ; poslat do VGA

        wait_key        ; cekani na klavesu

        exit            ; navrat do DOSu
