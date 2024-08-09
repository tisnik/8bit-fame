; Graficky rezim karty EGA s rozlisenim 320x200 pixelu.
; Zmena barvovych rovin, do kterych se zapisuje.
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu.
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Grafická karta EGA: pouze mírný pokrok v mezích zákona
; https://www.root.cz/clanky/graficka-karta-ega-pouze-mirny-pokrok-v-mezich-zakona/#k19
;
;
; preklad pomoci:
;     nasm -f bin -o ega.com ega_gfx_mode_bitplanes_1.asm
;
; nebo pouze:
;     nasm -o ega.com ega_gfx_mode_bitplanes_1.asm


;-----------------------------------------------------------------------------

; registry karty EGA/VGA
EGA_CONTROLLER    equ 0x3c4
BITPLANE_SELECTOR equ 0x02


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
        gfx_mode 0x0d       ; nastaveni rezimu 320x200 se sestnacti barvami
        mov ax, 0xa000      ; video RAM v textovem rezimu
        mov es, ax
        xor di, di          ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        xor al, al          ; maska bitovych rovin
        mov cl, 16          ; pocitadlo barevnych pruhu
opak:
        call draw_block_into_bitplanes
        loop opak

        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu

select_bitplane:
        mov  dx, EGA_CONTROLLER
        push ax
        mov  al, BITPLANE_SELECTOR
        out  dx, al         ; vyber registru sekvenceru
        pop  ax
        inc  dx
        out  dx, al         ; zapis masky bitovych rovin
        ret                 ; hotovo

draw_block_into_bitplanes:
        push ax
        push cx
        call select_bitplane; maska bitovych rovin
        call draw_block
        add  di, 320*3/8    ; posun o nekolik radku nize
        pop  cx
        pop  ax
        inc  al             ; zmena masky
        ret                 ; hotovo

draw_block:
        mov cx, 320*9/8     ; pocet zapisovanych pixelu (ovsem pocitano v bajtech)
        mov al, 0xff        ; kod pixelu
        rep stosb
        ret
