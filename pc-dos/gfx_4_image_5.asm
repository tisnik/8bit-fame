; Vykresleni rastroveho obrazku ziskaneho z binarnich dat.
; Korektni vykresleni vsech sudych i lichych radku obrazku.
;
; preklad pomoci:
;     nasm -f bin -o gfx_4.com gfx_4_image.asm
;
; nebo pouze:
;     nasm -o gfx_4.com gfx_4_image.asm


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
        gfx_mode 4      ; nastaveni grafickeho rezimu 320x200 se ctyrmi barvami

        mov ax, cs
        mov ds, ax
        mov si, image   ; nyni DS:SI obsahuje adresu prvniho bajtu v obrazku

        mov ax, 0xb800
        mov es, ax
        mov di, 0       ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        call move_half_image

        mov si, image+80; adresa prvniho pixelu na DRUHEM radku
        mov di, 8192    ; druha "stranka" video RAM
        call move_half_image

        wait_key
        exit

move_half_image:
        mov bl, 100     ; pocitadlo radku
outer_loop:
        mov cx, 80/2    ; velikost bloku ve slovech
        rep movsw       ; prenest jeden obrazovy radek
        add si, 80      ; preskocit lichy/sudy radek
        dec bl
        jnz outer_loop  ; opakovat smycku BL-krat
        ret


image:
    incbin "image.bin"