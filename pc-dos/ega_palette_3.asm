; Graficky rezim karty EGA s rozlisenim 640x350 pixelu.
; Zmena barvovych rovin, do kterych se zapisuje.
; Konfigurace barvove palety.
;
; preklad pomoci:
;     nasm -f bin -o ega.com ega_palette_3.asm
;
; nebo pouze:
;     nasm -o ega.com ega_palette_3.asm


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
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 436)

start:
        gfx_mode 0x10       ; nastaveni rezimu 640x200 se sestnacti barvami
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
        mov si, palette
        mov bl, 0           ; index barvy
next_color:
        mov bh, [cs:si]     ; hodnota barvy s indexem v BL
        int 0x10            ; zmena barvy
        inc bl              ; modifikace indexu
        inc si              ; modifikace adresy
        cmp bl, 16
        jne next_color      ; dalsi barva

        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu

palette:                    ; barvova paleta bez barvy okraje
        db 0b000000         ; cerna (pozadi)
        db 0b111000         ; tmave seda
        db 0b000111         ; svetle seda
        db 0b111111         ; bila
        db 0b010000         ; tmave zelena
        db 0b000010         ; stredne zelena
        db 0b010010         ; svetle zelena
        db 0b100000         ; tmave cervena
        db 0b000100         ; stredne cervena
        db 0b100100         ; svetle cervena
        db 0b001000         ; tmave modra
        db 0b000001         ; stredne modra
        db 0b001001         ; svetle modra
        db 0b110000         ; tmave hneda
        db 0b000110         ; svetle hneda
        db 0b110110         ; zluta

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
