; Textovy rezim karty Hercules s rozlisenim 80x25 znaku.
; Vypnuti video signalu.
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
;     nasm -f bin -o hercules.com hercules_turn_off.asm
;
; nebo pouze:
;     nasm -o hercules.com hercules_turn_off.asm


;-----------------------------------------------------------------------------

; registry karty Hercules
HERCULES_INDEX    equ 0x3b4
HERCULES_CONTROL  equ 0x3b8
HERCULES_STATUS   equ 0x3ba
HERCULES_CONFIG   equ 0x3bf


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


; nastaveni ridiciho registru
%macro set_control 1
        mov dx, HERCULES_CONTROL
        mov al, %1    ; ridici registr
        out dx, al
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        mov ax, 0xb000
        mov es, ax
        mov di, 0       ; nyni ES:DI obsahuje adresu prvniho znaku ve video RAM

        mov cx, 80*25   ; pocet zapisovanych znaku
        mov al, 0       ; kod zapisovaneho znaku
opak:
        stosb           ; zapis znaku + atributu
        stosb
        inc al          ; dalsi znak/atribut
        loop opak       ; opakujeme CX-krat

        wait_key

        set_control 0x00 ; zakaz zobrazeni

        wait_key
        exit
