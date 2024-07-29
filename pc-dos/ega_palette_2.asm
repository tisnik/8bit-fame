; Graficky rezim karty EGA s rozlisenim 640x350 pixelu.
; Zmena barvovych rovin, do kterych se zapisuje.
; Konfigurace barvove palety.
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
;     nasm -f bin -o ega.com ega_palette_2.asm
;
; nebo pouze:
;     nasm -o ega.com ega_palette_2.asm


;-----------------------------------------------------------------------------

; registry karty EGA/VGA
ega_controller    equ 0x3c4
bitplane_selector equ 0x02


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
        gfx_mode 0x10       ; nastaveni rezimu 640x350 se sestnacti barvami
        mov ax, 0xa000      ; video RAM v textovem rezimu
        mov es, ax
        xor di, di          ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        xor al, al          ; maska bitovych rovin
        mov cl, 16          ; pocitadlo barevnych pruhu
opak:
        call draw_block_into_bitplanes
        loop opak

        wait_key            ; cekani na klavesu

        mov ax, 0x1000      ; cislo sluzby a podsluzby BIOSu

        mov bl, 1           ; index barvy
        mov bh, 0b111000    ; tmave seda
        int 0x10            ; volani sluzby BIOSu pro zmenu jedne barvy

        mov bl, 2           ; index barvy
        mov bh, 0b000111    ; svetle seda
        int 0x10            ; volani sluzby BIOSu pro zmenu jedne barvy

        mov bl, 3           ; index barvy
        mov bh, 0b111111    ; bila
        int 0x10            ; volani sluzby BIOSu pro zmenu jedne barvy

        mov bl, 4           ; index barvy
        mov bh, 0b010000    ; tmave zelena
        int 0x10            ; volani sluzby BIOSu pro zmenu jedne barvy

        mov bl, 5           ; index barvy
        mov bh, 0b000010    ; stredne zelena
        int 0x10            ; volani sluzby BIOSu pro zmenu jedne barvy

        mov bl, 6           ; index barvy
        mov bh, 0b010010    ; svetle zelena
        int 0x10            ; volani sluzby BIOSu pro zmenu jedne barvy

        mov bl, 7           ; index barvy
        mov bh, 0b100000    ; tmave cervena
        int 0x10            ; volani sluzby BIOSu pro zmenu jedne barvy

        mov bl, 8           ; index barvy
        mov bh, 0b000100    ; stredne cervena
        int 0x10            ; volani sluzby BIOSu pro zmenu jedne barvy

        mov bl, 9           ; index barvy
        mov bh, 0b100100    ; svetle cervena
        int 0x10            ; volani sluzby BIOSu pro zmenu jedne barvy

        mov bl, 10          ; index barvy
        mov bh, 0b001000    ; tmave modra
        int 0x10            ; volani sluzby BIOSu pro zmenu jedne barvy

        mov bl, 11          ; index barvy
        mov bh, 0b000001    ; stredne modra
        int 0x10            ; volani sluzby BIOSu pro zmenu jedne barvy

        mov bl, 12          ; index barvy
        mov bh, 0b001001    ; svetle modra
        int 0x10            ; volani sluzby BIOSu pro zmenu jedne barvy

        mov bl, 13          ; index barvy
        mov bh, 0b110000    ; tmave hneda
        int 0x10            ; volani sluzby BIOSu pro zmenu jedne barvy

        mov bl, 14          ; index barvy
        mov bh, 0b000110    ; svetle hneda
        int 0x10            ; volani sluzby BIOSu pro zmenu jedne barvy

        mov bl, 15          ; index barvy
        mov bh, 0b110110    ; zluta
        int 0x10            ; volani sluzby BIOSu pro zmenu jedne barvy

        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu

select_bitplane:
        mov  dx, ega_controller
        mov  ah, bitplane_selector
        xchg ah, al
        out  dx, ax         ; vyber registru sekvenceru
                            ; a zapis masky bitovych rovin
        ret                 ; hotovo

draw_block_into_bitplanes:
        push ax
        push cx
        call select_bitplane; maska bitovych rovin
        call draw_block
        add  di, 640*3/8    ; posun o nekolik radku nize
        pop  cx
        pop  ax
        inc  al             ; zmena masky
        ret                 ; hotovo

draw_block:
        mov cx, 640*9/4     ; pocet zapisovanych pixelu (ovsem pocitano v bajtech)
        mov al, 0xff        ; kod pixelu
        rep stosb
        ret
