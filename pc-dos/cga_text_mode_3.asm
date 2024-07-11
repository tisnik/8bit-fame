; Textovy rezim karty CGA s rozlisenim 80x25 znaku.
;
; preklad pomoci:
;     nasm -f bin -o gfx_text.com gfx_cga_text_mode_1.asm
;
; nebo pouze:
;     nasm -o gfx_text.com gfx_cga_text_mode_1.asm


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

        mov cx, 40*25   ; pocet zapisovanych znaku
        mov al, 0       ; kod zapisovaneho znaku
opak:
        stosb           ; zapis znaku + atributu
        stosb
        inc al          ; dalsi znak/atribut
        loop opak       ; opakujeme CX-krat

        wait_key
        exit
