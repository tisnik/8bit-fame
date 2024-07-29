; Textovy rezim karty EGA s rozlisenim 80x25 znaku.
; Nastaveni vlastniho fontu.
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu.
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Grafická karta EGA: pouze mírný pokrok v mezích zákona (2. část)
; https://www.root.cz/clanky/graficka-karta-ega-pouze-mirny-pokrok-v-mezich-zakona-2-cast/
;
;
; preklad pomoci:
;     nasm -f bin -o ega.com ega_custom_font.asm
;
; nebo pouze:
;     nasm -o ega.com ega_custom_font.asm


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

        mov cx, 95      ; pocet zapisovanych znaku
        mov al, 32      ; kod zapisovaneho znaku
opak:
        stosb           ; zapis znaku
        inc al          ; dalsi znak
        inc di          ; preskocit atribut
        loop opak       ; opakujeme CX-krat

        mov ax, cs
        mov es, ax
        mov bp, font    ; ES:BP obsabuje adresu fontu

        mov ax, 0x1110  ; nacteni + nastaveni uzivatelskeho fontu
        mov cx, 95      ; pocet menenych znaku
        mov dx, 32      ; ASCII kod prvniho meneneho znaku
        mov bl, 0       ; index znakove sady
        mov bh, 16      ; vyska znaku
        int 0x10        ; provest operaci

        wait_key        ; cekani na klavesu
        exit            ; navrat do DOSu

font:
        incbin "font.bin"
