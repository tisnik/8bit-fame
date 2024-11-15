; Graficky rezim karty VGA s rozlisenim 320x200 pixelu.
; Konfigurace barvove palety jedinym volanim prislusne sluzby.
; Zmena hodnot ulozenych v DAC a korektnim mapovanim barev.
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; preklad pomoci:
;     nasm -f bin -o vga.com vga_gfx_mode_dac_3.asm
;
; nebo pouze:
;     nasm -o vga.com vga_gfx_mode_dac_3.asm


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
        gfx_mode 0x13       ; nastaveni rezimu 320x200 s 256 barvami
        mov ax, 0xa000      ; video RAM v textovem rezimu
        mov es, ax
        xor di, di          ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        mov dl, 0           ; pocitadlo radku
opak:
        call draw_line      ; vykresleni radku barvou v DL
        inc  dl             ; dalsi barva
        cmp  dl, 199        ; posledni radek na obrazovce?
        jne  opak           ; ne? opakujeme

        wait_key            ; cekani na klavesu

        mov ax, 0x1010      ; cislo sluzby a podsluzby VGA BIOSu
        xor cl, cl          ; hodnoty barvovych slozek
        xor dh, dh          ; -//-
next_dac:
        mov ch, bl          ; prvni barvova slozka
        cmp bl, 64          ; nastavit i dalsi nebo ne?
        ja  skip_g
        mov cl, ch          ; druha barvova slozka
skip_g:
        cmp bl, 128         ; nastavit i dalsi nebo ne?
        ja  skip_b
        mov dh, ch          ; treti barvova slozka
skip_b:
        int 0x10            ; modifikace mapovani v DAC
        inc bl              ; zvysit index v DAC
        jnz next_dac        ; nastavit dalsi barvu, dokud nedosahneme hodnoty 256

        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu

draw_line:
        mov cx, 320         ; pocitadlo pixelu na radku
        mov al, dl          ; barva
        rep stosb           ; vyplnit cely radek
        ret                 ; hotovo
