; Graficky rezim karty VGA s rozlisenim 320x400 pixelu.
; Vypnuti zretezeni bitovych rovin.
;
; preklad pomoci:
;     nasm -f bin -o vga.com vga_gfx_mode_320x400.asm
;
; nebo pouze:
;     nasm -o vga.com vga_gfx_mode_320x400.asm


;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 8086        ; specifikace pouziteho instrukcniho souboru

;-----------------------------------------------------------------------------

; registry karty VGA
SEQUENCER_INDEX      equ 0x3c4
SEQUENCER_DATA       equ 0x3c5
CRTC_INDEX           equ 0x3d4
CRTC_DATA            equ 0x3d5
BITPLANE_SELECTOR    equ 0x02
MEMORY_MODE_REGISTER equ 0x04   ; sekvencer
UNDERLINE_LOCATION   equ 0x14   ; CRTC
MODE_CONTROL         equ 0x17   ; CRTC
MAXIMUM_SCAN_LINE    equ 0x09   ; CRTC

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

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        gfx_mode 0x13       ; nastaveni rezimu 320x200 s 256 barvami

        set_sequencer_register MEMORY_MODE_REGISTER, 0x06 ; vypnuti zretezeni + povoleni 256 kB RAM
        set_crtc_register UNDERLINE_LOCATION, 0x00        ; vypnuti double word rezimu
        set_crtc_register MODE_CONTROL,  0xe3             ; zapnuti bytoveho rezimu
        set_crtc_register MAXIMUM_SCAN_LINE, 0x40         ; 400 grafickych radku

        mov ax, 0xa000      ; video RAM v textovem rezimu
        mov es, ax
        mov di, 0           ; nyni ES:DI obsahuje adresu prvniho pixelu ve video RAM

        mov al, 3           ; kod barvy pixelu
        call fill_block

        select_bitplane 1   ; zapis jen do jedine bitove roviny

        mov al, 4           ; kod barvy pixelu
        call fill_block

        wait_key            ; cekani na klavesu

        sub di, 320*200/8   ; posun zpet
        select_bitplane 7   ; zapis jen do tri bitovych rovin
        mov al, 5           ; kod barvy pixelu
        call fill_block

        wait_key            ; cekani na klavesu
        exit                ; navrat do DOSu


fill_block:
        mov cx, 320*200/8   ; pocet zapisovanych pixelu (pixel==bajt)
opak:
        stosb               ; zapis barvy pixelu
        loop opak           ; opakujeme CX-krat
        ret                 ; hotovo
