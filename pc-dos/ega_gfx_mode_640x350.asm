; Graficky rezim karty EGA s rozlisenim 640x350 pixelu.
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Grafická karta EGA: pouze mírný pokrok v mezích zákona
; https://www.root.cz/clanky/graficka-karta-ega-pouze-mirny-pokrok-v-mezich-zakona/#k19
;
;
; preklad pomoci:
;     nasm -f bin -o ega.com ega_gfx_mode_640x350.asm
;
; nebo pouze:
;     nasm -o ega.com ega_gfx_mode_640x350.asm

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
        gfx_mode 0x10       ; nastaveni rezimu 640x350 se ctyrmi nebo sestnacti barvami
        mov ax, 0xa000      ; video RAM v textovem rezimu
        mov es, ax
        mov di, 0           ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        mov cx, 640*350/8   ; pocet zapisovanych pixelu (ovsem pocitano v bajtech)
        mov al, 0           ; kod pixelu
opak:
        stosb
        inc al              ; dalsi znak/atribut
        loop opak           ; opakujeme CX-krat

        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu
