; Pseudograficky rezim 160x100x16.
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

; nastaveni jednoho CRTC registru
%macro set_crtc 2
        mov dx, 0x3d4
        mov al, %1    ; ridici registr (CRTC)
        out dx, al
        mov dx, 0x3d5
        mov al, %2    ; hodnota zapisovana do registru
        out dx, al
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        gfx_mode 3      ; nastaveni textoveho rezimu 80x25 znaku

        mov ax, 0xb800
        mov es, ax
        mov di, 0       ; nyni ES:DI obsahuje adresu prvniho znaku ve video RAM

        mov cx, 80*100  ; pocet zapisovanych znaku
opak:
        mov al, 0xde    ; kod zapisovaneho znaku
        stosb           ; zapis znaku
        mov al, cl      ; kod zapisovaneho atributu
        stosb
        inc al          ; dalsi znak/atribut
        loop opak       ; opakujeme CX-krat

        mov dx, 0x3d8   ; port s rizenim graficke palety
        mov al, 0x18    ; pozadi neblika, meni se intenzita
        out dx, al      ; pres port 0x3d9

        set_crtc 0x04, 0x7f ; celkovy pocet obrazovych radku (scanlines)
        set_crtc 0x06, 100  ; pocet zobrazenych radku z celkoveho poctu
        set_crtc 0x07, 0x70 ; pozice synchronizacniho signalu
        set_crtc 0x09, 1    ; vyska znaku 2 scanline

        wait_key

        exit
