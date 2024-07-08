; Vykresleni vertikalni sady pixelu.
;
; preklad pomoci:
;     nasm -f bin -o gfx_6.com gfx_6_ver_fill_1.asm
;
; nebo pouze:
;     nasm -o gfx_6.com gfx_6_ver_fill_1.asm


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
        gfx_mode 6        ; nastaveni grafickeho rezimu 640x200 se 2 barvami
        wait_key

        mov ax, 0xb800    ; video segment
        mov es, ax        ; do segmentoveho registru ES
        xor di, di        ; adresa pro zapis barev pixelu
        mov al, 255       ; zapisovana kombinace barev pixelu
        mov cx, 640*200/8 ; pocitadlo smycky

        rep stosb         ; vlastni vyplneni

        wait_key
        exit
