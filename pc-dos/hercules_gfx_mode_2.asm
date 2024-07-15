; Graficky rezim karty Hercules s rozlisenim 720x348 znaku.
;
; preklad pomoci:
;     nasm -f bin -o hercules.com hercules_gfx_mode_2.asm
;
; nebo pouze:
;     nasm -o hercules.com hercules_gfx_mode_2.asm


;-----------------------------------------------------------------------------

; registry karty Hercules
hercules_index    equ 0x3b4
hercules_data     equ 0x3b5
hercules_control  equ 0x3b8
hercules_status   equ 0x3ba
hercules_config   equ 0x3bf

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
        mov dx, hercules_config
        mov al, %1    ; ridici registr
        out dx, al
%endmacro

; nastaveni ridiciho registru
%macro set_control 1
        mov dx, hercules_control
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

        mov     dx, hercules_index       ; registr pro zapis
        mov     cx, 12                   ; pocet nastavovanych parametru
        xor     ah, ah                   ; zaciname registrem cislo 0

parms:  mov     al, ah                   ; zapis cisla registru
        out     dx, al

        inc     dx                       ; adresa portu datoveho registru
        lodsb                            ; precist hodnotu registru z tabulky
        out     dx, al                   ; zapis hodnoty registru na port

        inc     ah                       ; dalsi CRTC registr
        dec     dx                       ; obnoveni cisla portu
        loop    parms                    ; go do another one

        set_control graphics + screen_on ; zapnuti obrazovky
        ret                              ; vse hotovoa


gtable: db      35h,2dh,2eh,07h
        db      5bh,02h,57h,57h
        db      02h,03h,00h,00h

