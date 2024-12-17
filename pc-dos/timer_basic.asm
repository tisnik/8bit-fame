; Pouziti casovace
;
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
;
; preklad pomoci:
;     nasm -f bin -o timer_basic.com timer_basic.asm
;
; nebo pouze:
;     nasm -o timer_basic.com timer_basic.asm

;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 286         ; specifikace pouziteho instrukcniho souboru

IRQ_0_VECTOR equ 0x0020  ; adresa vektoru preruseni pro IRQ 0
 
;-----------------------------------------------------------------------------

; ukonceni procesu a navrat do DOSu
%macro exit 0
        ret
%endmacro

; vyprazdneni bufferu klavesnice a cekani na klavesu
%macro wait_key 0
        xor     ax, ax
        int     0x16          ; vyvolani sluzby BIOSu
%endmacro

; tisk jedineho znaku pres DOS
%macro print_char 1
        mov     ah, 0x02      ; cislo sluzby DOSu
        mov     dl, %1        ; kod zapisovaneho znaku
        int     0x21          ; vyvolani sluzby DOSu
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        print_char '>'          ; oznameni uzivateli, ze jsme pripraveni

        xor  ax, ax
        mov  es, ax
        mov  di, IRQ_0_VECTOR   ; ES:DI obsahuje adresu, na ktere je adresa obsluhy preruseni 0x08

        cli                     ; zakaz preruseni
        lea  ax, int8_handler   ; zmena offsetove casti adresy
        mov  es:[di], ax

        mov  ax, cs             ; zmena segmentove casti adresy
        mov  es:[di+2], ax
        sti                     ; povoleni preruseni

        wait_key                ; cekani na stisk klavesy
        print_char '.'          ; oznameni uzivateli, ze ukoncujeme proces

        exit                    ; ukonceni procesu
 

int8_handler:                   ; nova obsluha preruseni
        pusha                   ; ulozit vsechny registry
        print_char 't'          ; t=tick

        mov al, 0x20
        out 0x20, al            ; oznameni, ze preruseni je u konce radici preruseni 

        popa                    ; obnovit vsechny registry
        sti                     ; povoleni maskovatelnych preruseni
        iret                    ; navrat z preruseni

