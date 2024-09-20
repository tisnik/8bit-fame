; Graficky rezim karty VGA s rozlisenim 320x200 pixelu.
; Vykresleni rastroveho obrazku, prenos 0 bajtu.
;
; preklad pomoci:
;     nasm -f bin -o vga.com vga_320x200_image_0B.asm
;
; nebo pouze:
;     nasm -o vga.com vga_320x200_image_0B.asm


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

; paleta ve stupnich sedi
%macro grayscale_palette 0
        mov ax, 0x1010      ; cislo sluzby a podsluzby VGA BIOSu
        xor bl, bl          ; index barvy
next_dac:
        mov ch, bl          ; prvni barvova slozka
        shr ch, 1
        shr ch, 1
        mov cl, ch          ; druha barvova slozka
        mov dh, ch          ; treti barvova slozka
        int 0x10            ; modifikace mapovani v DAC
        inc bl              ; zvysit index v DAC
        jnz next_dac        ; nastavit dalsi barvu, dokud nedosahneme hodnoty 256
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        gfx_mode 0x13       ; nastaveni rezimu 320x200 s 256 barvami
        grayscale_palette   ; nastaveni palety se stupni sedi

        mov ax, cs
        mov ds, ax
        mov si, image       ; nyni DS:SI obsahuje adresu prvniho bajtu v obrazku

        mov ax, 0xa000      ; video RAM v textovem rezimu
        mov es, ax
        xor di, di          ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        xor cx, cx          ; pocet zapisovanych bajtu (=pixelu)
        rep movsb           ; prenos celeho obrazku

        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu

; pridani binarnich dat s rastrovym obrazkem
image:
    incbin "image_320x200.bin"
