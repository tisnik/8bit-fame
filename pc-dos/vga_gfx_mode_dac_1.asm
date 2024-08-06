; Graficky rezim karty VGA s rozlisenim 640x480 pixelu.
; Zmena barvovych rovin, do kterych se zapisuje.
; Konfigurace barvove palety jedinym volanim prislusne sluzby.
; Zmena hodnot ulozenych v DAC.
;
; preklad pomoci:
;     nasm -f bin -o vga.com vga_gfx_mode_dac_1.asm
;
; nebo pouze:
;     nasm -o vga.com vga_gfx_mode_dac_1.asm


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
        gfx_mode 0x12       ; nastaveni rezimu 640x480 se sestnacti barvami
        mov ax, 0xa000      ; video RAM v textovem rezimu
        mov es, ax
        xor di, di          ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        xor al, al          ; maska bitovych rovin
        mov cl, 16          ; pocitadlo barevnych pruhu
opak:
        call draw_block_into_bitplanes
        loop opak

        wait_key            ; cekani na klavesu

        xor bx, bx          ; index barvy v DAC
        mov ax, 0x1010
next_dac:
        mov ch, bl
        shl ch, 1
        shl ch, 1           ; index (0-15)*4 -> 0..60
        mov cl, ch          ; nastavit i ostatni slozky
        mov dh, ch          ; nastavit i ostatni slozky
        int 0x10            ; modifikace mapovani v DAC
        inc bl              ; zvysit index v DAC
        cmp bl, 16
        jnz next_dac

        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu

select_bitplane:
        mov  dx, EGA_CONTROLLER
        mov  ah, BITPLANE_SELECTOR
        xchg ah, al
        out  dx, ax         ; vyber registru sekvenceru
                            ; a zapis masky bitovych rovin
        ret                 ; hotovo

draw_block_into_bitplanes:
        push ax
        push cx
        call select_bitplane; maska bitovych rovin
        call draw_block
        add  di, 640*4/8    ; posun o nekolik radku nize
        pop  cx
        pop  ax
        inc  al             ; zmena masky
        ret                 ; hotovo

draw_block:
        mov cx, 640*12/4    ; pocet zapisovanych pixelu (ovsem pocitano v bajtech)
        mov al, 0xff        ; kod pixelu
        rep stosb
        ret
