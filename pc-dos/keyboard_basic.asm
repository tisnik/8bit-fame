; Zaklad prace s klavesnici
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
;
; preklad pomoci:
;     nasm -f bin -o keyboard_basic.com keyboard_basic.asm
;
; nebo pouze:
;     nasm -o keyboard_basic.com keyboard_basic.asm

 
;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 8086        ; specifikace pouziteho instrukcniho souboru

;-----------------------------------------------------------------------------

; registry PPI
PPI_PORT_A equ 0x60
PPI_PORT_B equ 0x61

; kody klaves
KEY_ESC     equ 0x01
KEY_SPACE   equ 0x39
KEY_RELEASE equ 0x80

;-----------------------------------------------------------------------------

; ukonceni procesu a navrat do DOSu
%macro exit 0
        ret
%endmacro

; tisk retezce na obrazovku
%macro print 1
        mov     dx, %1
        mov     ah, 9
        int     0x21
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        in  al, PPI_PORT_B   ; port B s rizenim zarizeni
        or  al, 0b1000000    ; nastaveni bitu cislo 7 na jednicku
        out PPI_PORT_B, al   ; zapis zpet na port B

.opak:
        in  al, PPI_PORT_A   ; cteni stisknute klavesy
        cmp al, KEY_ESC      ; test stisknute klavesy
        jne .opak            ; neni stisknuta? -> zkusme znovu

        exit

