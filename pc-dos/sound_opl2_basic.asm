; Prehrani zakladniho tonu na kartach s cipem OPL2.
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
;
; preklad pomoci:
;     nasm -f bin -o sound_opl2_basic.com sound_opl2_basic.asm
;
; nebo pouze:
;     nasm -o sound_opl2_basic.com sound_opl2_basic.asm

;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 8086        ; specifikace pouziteho instrukcniho souboru

 
;-----------------------------------------------------------------------------

; registry karet s cipem OPL2
OPL_ADDRESS equ 0x388
OPL_DATA    equ 0x389

;-----------------------------------------------------------------------------

; ukonceni procesu a navrat do DOSu
%macro exit 0
        ret
%endmacro

; vyprazdneni bufferu klavesnice a cekani na klavesu
%macro wait_key 0
        xor     ax, ax
        int     0x16
%endmacro

; makro pro zapis do registru OPL2
%macro write_opl_register 2
        mov     al, %1
        mov     ah, %2
        call    perform_write_to_opl_register
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        write_opl_register 0x20, 0x01    ; nastaveni modulatoru: nasobeni frekvence jednickou
        write_opl_register 0x40, 0x10    ; uroven vystupu 40 dB
        write_opl_register 0x60, 0xF0    ; modulator: rychly nastup zvuku + pomale doznivani
        write_opl_register 0x80, 0x77    ; urovne sustain a release pro modulator
        write_opl_register 0xA0, 0x41    ; frekvence zvuku (komorni A = 440 Hz)
        write_opl_register 0x23, 0x01    ; nastaveni nosne: nasobeni frekvence jednickou
        write_opl_register 0x43, 0x00    ; nastaveni urovne vystupu nosne na 47 dB
        write_opl_register 0x63, 0xF0    ; nosna: rychly nastup + pomale doznivani
        write_opl_register 0x83, 0x77    ; urovne sustain a release pro nosnou
        write_opl_register 0xB0, 0x32    ; zapnuti/povoleni zvuku + nastaveni oktavy a vyssich bitu frekvence
        wait_key
        exit

perform_write_to_opl_register:
        ; zapis do vybraneho registru OPL2
        ; AL - registr
        ; AH - hodnota
        mov dx, OPL_ADDRESS   ; vyber registru pro modifikaci
        out dx, al

        ; cekani priblizne 3.3 mikrosekundy
        mov cl, 6
.delay1:
        in  al, dx
        loop .delay1

        mov al, ah            ; zapis hodnoty do vybraneho registru
        mov dx, OPL_DATA
        out dx, al

        ; cekani priblizne 23 mikrosekund
        mov cl, 35
.delay2:
        in  al, dx
        loop .delay2
 
        ret
