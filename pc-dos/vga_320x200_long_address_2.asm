; Graficky rezim karty VGA s rozlisenim 320x200 pixelu.
; Vykresleni rastroveho obrazku s explicitnim prenosem po ctyrech bajtech.
; Pro blokovy prenos se pouziva programova smycka
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; preklad pomoci:
;     nasm -f bin -o vga.com vga_320x200_long_address_2.asm
;
; nebo pouze:
;     nasm -o vga.com vga_320x200_long_address_2.asm


;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU  386        ; specifikace pouziteho instrukcniho souboru

;-----------------------------------------------------------------------------

; ukonceni procesu a navrat do DOSu
%macro exit 0
        mov     ah, 0x4c    ; cislo sluzby DOSu
        int     0x21        ; zavolani sluzby DOSu
%endmacro

; vyprazdneni bufferu klavesnice a cekani na klavesu
%macro wait_key 0
        xor     ax, ax      ; cislo sluzby BIOSu
        int     0x16        ; zavolani sluzby BIOSu
%endmacro

; nastaveni grafickeho rezimu
%macro gfx_mode 1
        mov     ah, 0       ; cislo sluzby VGA BIOSu
        mov     al, %1      ; cislo grafickeho rezimu
        int     0x10        ; zavolani sluzby BIOSu
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
        mov esi, image      ; nyni dvojice DS:ESI obsahuje adresu prvniho bajtu v obrazku

        mov ax, 0xa000      ; (lze i PUSH 0xa000 + POP ES)
        mov es, ax
        xor edi, edi        ; nyni dvojice ES:EDI obsahuje adresu prvniho pixelu ve video RAM   

        mov cx, 320*200/4   ; pocet zapisovanych 32bitovych slov (=ctveric pixelu)

move_loop:                  ; prenos celeho obrazku po 32bitovych slovech
        mov eax, ds:[esi]   ; nacteni ctyr bajtu
        mov es:[edi], eax   ; ulozeni ctyr bajtu
        add esi, 4          ; posun offsetu
        add edi, 4
        loop move_loop      ; opakujeme

        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu

; pridani binarnich dat s rastrovym obrazkem
image:
    incbin "image_320x200.bin"
