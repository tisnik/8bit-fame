; Graficky rezim karty VGA s rozlisenim 320x240 pixelu.
; Vypnuti zretezeni bitovych rovin.
; Vykresleni rastroveho obrazku postupne do vsech bitovych rovin.
; Odskrolovani obrazku.
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; preklad pomoci:
;     nasm -f bin -o vga.com vga_320x240_image.asm
;
; nebo pouze:
;     nasm -o vga.com vga_320x240_image.asm

; Nastaveni registru VGA pro rezim X
; ------------------------------------------------------
; Register name            port    index   13h    mode X
; Miscellaneous Output     0x3C2   N/A     0x63    0xE3
; Memory Mode Register     0x3C4   0x04    0x0E    0x06
; Mode Register            0x3CE   0x05    0x40    0x40
; Miscellaneous Register   0x3CE   0x06    0x05    0x05
; Vertical Total           0x3D4   0x06    0xBF    0x0D
; Overflow Register        0x3D4   0x07    0x1F    0x3E
; Vertical Retrace Start   0x3D4   0x10    0x9C    0xEA
; Vertical Retrace End     0x3D4   0x11    0x8E    0xAC
; Vertical Display End     0x3D4   0x12    0x8F    0xDF
; Underline Location       0x3D4   0x14    0x40    0x00
; Vertical Blank Start     0x3D4   0x15    0x96    0xE7
; Vertical Blank End       0x3D4   0x16    0xB9    0x06
; Mode Control             0x3D4   0x17    0xA3    0xE3 


;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 8086        ; specifikace pouziteho instrukcniho souboru

;-----------------------------------------------------------------------------

; registry karty VGA
MISC_REGISTER        equ 0x3c2
SEQUENCER_INDEX      equ 0x3c4
SEQUENCER_DATA       equ 0x3c5
CRTC_INDEX           equ 0x3d4
CRTC_DATA            equ 0x3d5
INPUT_STATUS         equ 0x3da
BITPLANE_SELECTOR    equ 0x02
MEMORY_MODE_REGISTER equ 0x04   ; sekvencer
UNDERLINE_LOCATION   equ 0x14   ; CRTC
MODE_CONTROL         equ 0x17   ; CRTC
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

        ; prepnuti do 320x240
        mov dx, SEQUENCER_INDEX
        mov ax, 0x100       ; synchronni reset (bit cislo 1 je vynulovan)
        out dx, ax

        mov dx, MISC_REGISTER
        mov al, 0xe3
        out dx, al          ; hodiny 25 MHz obrazova frekvence 60 Hz (nastaveni polarity syncu)

        mov dx, SEQUENCER_INDEX
        mov ax, 0x300       ; restart sekvenceru (oba resety jsou zakazane)
        out dx, ax

        mov dx, CRTC_INDEX
        mov al, 0x11        ; Vertical Retrace End registr
        out dx, al

        inc dx
        in al, dx           ; cteni hodnoty registru
        and al, 0x7f        ; vypnout write protect bit (sedmi bit)
        out dx, al          ; nyni lze zapisovat do jakehokoli CRTC registru

        mov dx, CRTC_INDEX  ; budou se zapisovat hodnoty CRTC registru
        cld                 ; smer prenosu (pro jistotu)
        mov si, crtc_values ; tabulka s hodnotami CRTC registru
        mov cx, 10          ; velikost tabulky s hodnotami CRTC registru
set_crtc:
        lodsw               ; nacteni dvojice: index registru + hodnota registru
        out dx, ax          ; zapis do zvoleneho CRTC registru
        loop set_crtc       ; provest vsech 10 zapisu

        mov ax, cs
        mov ds, ax          ; zajistit, ze bude mozne adresovat cely obrazek

        mov ax, 0xa000      ; video RAM v textovem rezimu
        mov es, ax

        select_bitplane 1   ; prvni bitplane
        xor ax, ax          ; offset pixelu
        call move_image_part; prenest obrazek
        wait_key            ; cekani na klavesu

        select_bitplane 2   ; druha bitplane
        mov ax, 1
        call move_image_part; prenest obrazek
        wait_key            ; cekani na klavesu

        select_bitplane 4   ; treti bitplane
        mov ax, 2
        call move_image_part; prenest obrazek
        wait_key            ; cekani na klavesu

        select_bitplane 8   ; ctvrta bitplane
        mov ax, 3
        call move_image_part; prenest obrazek
        wait_key            ; cekani na klavesu

        mov cx, 40          ; pocet radku, o ktere budeme scrollovat
        xor bx, bx          ; adresa zacatku vykreslovani

opak:
        add bx, 80          ; prechod na dalsi adresu, od ktere se bude vykreslovat
        call wait_sync      ; cekani na sync.
                            ; zmena adresy
        set_crtc_register START_ADDRESS_HIGH, bh
        set_crtc_register START_ADDRESS_LOW, bl
        loop opak

        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu

move_image_part:
        mov si, image       ; nyni DS:SI obsahuje adresu prvniho bajtu v obrazku
        add si, ax          ; offset pixelu
        mov di, 40*80       ; adresa, kam se bude vykreslovat

        mov cx, 320*200/4   ; pocet zapisovanych bajtu (=pixelu)
bitblt:
        lodsb               ; nacist bajt z obrazku
        add si, 3           ; celkove posun o 4 pixely v obrazku 
        stosb               ; ulozit do obrazove pameti
        loop bitblt         ; presunout CX pixelu
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

crtc_values:
        dw 00d06h           ; Vertical Total
        dw 03e07h           ; Overflow Register
        dw 04109h           ; Cell Height (teoreticky nemusime menit)
        dw 0ea10h           ; Vertical Retrace Start
        dw 0ac11h           ; Vertical Retrace End
        dw 0df12h           ; Vertical Display End
        dw 00014h           ; Underline Location
        dw 0e715h           ; Vertical Blank Start
        dw 00616h           ; Vertical Blank End
        dw 0e317h           ; Mode Control
