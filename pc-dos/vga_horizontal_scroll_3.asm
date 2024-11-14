; Graficky rezim karty VGA s rozlisenim 320x400 pixelu.
; Vypnuti zretezeni bitovych rovin.
; Vykresleni rastroveho obrazku postupne do vsech bitovych rovin.
; Nastaveni "sirokych" obrazovych radku.
; Jemny horizontalni scrolling po stisku klavesy.
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; preklad pomoci:
;     nasm -f bin -o vga.com vga_horizontal_scroll_3.asm
;
; nebo pouze:
;     nasm -o vga.com vga_horizontal_scroll_3.asm


;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 8086        ; specifikace pouziteho instrukcniho souboru

;-----------------------------------------------------------------------------

; registry karty VGA
ATTRIBUTE_CONTROLLER equ 0x3c0
SEQUENCER_INDEX      equ 0x3c4
SEQUENCER_DATA       equ 0x3c5
CRTC_INDEX           equ 0x3d4
CRTC_DATA            equ 0x3d5
INPUT_STATUS         equ 0x3da
BITPLANE_SELECTOR    equ 0x02
MEMORY_MODE_REGISTER equ 0x04   ; sekvencer
OFFSET               equ 0x13   ; CRTC
UNDERLINE_LOCATION   equ 0x14   ; CRTC
MODE_CONTROL         equ 0x17   ; CRTC
MAXIMUM_SCAN_LINE    equ 0x09   ; CRTC
START_ADDRESS_HIGH   equ 0x0c   ; CRTC
START_ADDRESS_LOW    equ 0x0d   ; CRTC

; bitove masky
V_RETRACE            equ 0x08

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

; nastaveni jednoho registru sekvenceru
%macro set_sequencer_register 2
        mov dx, SEQUENCER_INDEX
        mov al, %1    ; ridici registr
        out dx, al
        inc dx
        mov al, %2    ; hodnota zapisovana do registru
        out dx, al
%endmacro

; nastaveni jednoho CRTC registru
%macro set_crtc_register 2
        mov dx, CRTC_INDEX
        mov al, %1    ; ridici registr (CRTC)
        out dx, al
        inc dx
        mov al, %2    ; hodnota zapisovana do registru
        out dx, al
%endmacro

; vyber bitove roviny
%macro select_bitplane 1
        mov  al, %1         ; bitova rovina
        mov  dx, SEQUENCER_INDEX
        mov  ah, BITPLANE_SELECTOR
        xchg ah, al
        out  dx, ax         ; vyber registru sekvenceru
                            ; a zapis masky bitovych rovin
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

                            ; mod 320x200 bez zretezeni rovin
        set_sequencer_register MEMORY_MODE_REGISTER, 0x06 ; vypnuti zretezeni + povoleni 256 kB RAM
        set_crtc_register UNDERLINE_LOCATION, 0x00        ; vypnuti double word rezimu
        set_crtc_register MODE_CONTROL,  0xe3             ; zapnuti bytoveho rezimu
        set_crtc_register MAXIMUM_SCAN_LINE, 0x40         ; 400 grafickych radku
        set_crtc_register OFFSET, 80                      ; 640 pixelu na radku (320 zobrazenych)

        mov ax, cs
        mov ds, ax          ; zajistit, ze bude mozne adresovat cely obrazek

        mov ax, 0xa000      ; video RAM v textovem rezimu
        mov es, ax

        select_bitplane 1   ; prvni bitplane
        xor ax, ax          ; offset pixelu
        call move_image_part; prenest obrazek

        select_bitplane 2   ; druha bitplane
        mov ax, 1
        call move_image_part; prenest obrazek

        select_bitplane 4   ; treti bitplane
        mov ax, 2
        call move_image_part; prenest obrazek

        select_bitplane 8   ; ctvrta bitplane
        mov ax, 3
        call move_image_part; prenest obrazek

        wait_key

        mov cx, 80          ; pocet bajtu(!), o ktere budeme scrollovat
        xor bx, bx          ; adresa zacatku vykreslovani

opak:
        mov ah, 0           ; jemny posun
fine_scroll_opak:
        call wait_sync      ; cekani na sync.
        call fine_scroll    ; jemny posun o AH pixelu
        inc ah
        cmp ah, 8           ; jak se posuneme o 8, muzeme jit o bajt dale
        jne fine_scroll_opak

        inc bx              ; posun o jediny pixel
                            ; zmena adresy
        set_crtc_register START_ADDRESS_HIGH, bh
        set_crtc_register START_ADDRESS_LOW, bl
        loop opak

        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu

fine_scroll:
        mov dx, ATTRIBUTE_CONTROLLER
        mov al, 0x33        ; PEL panning
        out dx, al          ; index registru
        mov al, ah
        out dx, al          ; hodnota registru
        ret

move_image_part:
        mov si, image       ; nyni DS:SI obsahuje adresu prvniho bajtu v obrazku
        add si, ax          ; offset pixelu
        mov di, 320*50      ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM
                            ; kam budeme chtit provest vykreslovani
        add di, 80          ; posun zacatku tak, aby obrazek zacinal "za rohem"

        mov dl, 200         ; pocitadlo radku
next_scan_line:
        mov cx, 320/4       ; pocet zapisovanych bajtu (=pixelu)
bitblt:
        lodsb               ; nacist bajt z obrazku
        add si, 3           ; celkove posun o 4 pixely v obrazku 
        stosb               ; ulozit do obrazove pameti
        loop bitblt         ; presunout CX pixelu
                            ; nyni je vykresleny jeden radek
        add di, 80          ; preskocit zbytek obrazoveho radku
        dec dl              ; dalsi radek?
        jnz next_scan_line  ; ok, dalsi radek
       
        ret

wait_sync:
        mov dx, INPUT_STATUS ; adresa stavoveho registru graficke karty CGA
wait_sync_end:
        in al, dx           ; precteni hodnoty stavoveho registru
        test al, V_RETRACE  ; odmaskovat priznak vertikalniho synchronizacniho pulsu
        jnz wait_sync_end   ; probiha - cekat na konec
wait_sync_start:
        in al, dx           ; precteni hodnoty stavoveho registru
        test al, V_RETRACE  ; odmaskovat priznak vertikalniho synchronizacniho pulsu
        jz wait_sync_start  ; neprobiha - cekat na zacatek
        ret                 ; ok - synchronizacni kurz probiha, lze zapisovat do pameti

; pridani binarnich dat s rastrovym obrazkem
image:
    incbin "image_320x200.bin"
