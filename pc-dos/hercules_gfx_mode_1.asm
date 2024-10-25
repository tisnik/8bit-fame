; Graficky rezim karty Hercules s rozlisenim 720x348 pixelu.
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu.
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Grafická karta Hercules: úspěšná alternativa a konkurence MDA i CGA
; https://www.root.cz/clanky/graficka-karta-hercules-uspesna-alternativa-a-konkurence-mda-i-cga/
;
;
; preklad pomoci:
;     nasm -f bin -o hercules.com hercules_gfx_mode_1.asm
;
; nebo pouze:
;     nasm -o hercules.com hercules_gfx_mode_1.asm

;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 8086        ; specifikace pouziteho instrukcniho souboru


;-----------------------------------------------------------------------------

; registry karty Hercules
HERCULES_INDEX    equ 0x3b4
HERCULES_DATA     equ 0x3b5
HERCULES_CONTROL  equ 0x3b8
HERCULES_STATUS   equ 0x3ba
HERCULES_CONFIG   equ 0x3bf

; ridici bity
screen_on equ 0x08
graphics  equ 0x02
text      equ 0x20
enable    equ 0x03



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

; nastaveni konfiguracniho registru
%macro set_config 1
        mov dx, HERCULES_CONFIG
        mov al, %1    ; ridici registr
        out dx, al
%endmacro

; nastaveni ridiciho registru
%macro set_control 1
        mov dx, HERCULES_CONTROL
        mov al, %1    ; ridici registr
        out dx, al
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        call init_graphics

        mov ax, 0xb000
        mov es, ax
        mov di, 0         ; nyni ES:DI obsahuje adresu prvniho znaku ve video RAM

        mov cx, 90*348/4  ; pocet zapisovanych bajtu
        mov al, 255       ; kod zapisovaneho bajtu
opak:
        stosb             ; zapis bajtu
        loop opak         ; opakujeme CX-krat

        wait_key
        exit              ; hotovo


init_graphics:
        set_config enable
        set_control graphics

        ; inicializace ridicich registru cipu Motorola 6845
        mov     si, gtable               ; DS:SI obsahuje adresu tabulky s hodnotami registru

        mov     cx, 12                   ; pocet nastavovanych parametru
        xor     ah, ah                   ; zaciname registrem cislo 0

parms: 
        mov     dx, HERCULES_INDEX       ; port pro zapis
        mov     al, ah
        out     dx, al                   ; zapis cisla registru na port

        mov     dx, HERCULES_DATA        ; port pro zapis
        lodsb                            ; precist hodnotu registru z tabulky
        out     dx, al                   ; zapis hodnoty registru na port

        inc     ah                       ; dalsi CRTC registr
        loop    parms                    ; go do another one

        set_control graphics + screen_on ; zapnuti obrazovky
        ret                              ; vse hotovoa


gtable: db      35h,2dh,2eh,07h
        db      5bh,02h,57h,57h
        db      02h,03h,00h,00h

