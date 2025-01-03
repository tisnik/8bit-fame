; Instrukcni soubor mikroprocesoru Intel 80386.
; Presuny dat do a ze segmentovych registru.
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 386         ; specifikace pouziteho instrukcniho souboru

; ukonceni procesu a navrat do DOSu
%macro exit 0
        ret
%endmacro

; vyprazdneni bufferu klavesnice a cekani na klavesu
%macro wait_key 0
        xor     ax, ax
        int     0x16
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        mov  ax, ds
        mov  ax, es
        mov  ax, fs
        mov  ax, gs
        mov  ax, ss
        mov  ax, cs

        xor  ax, ax
        mov  ds, ax
        mov  es, ax
        mov  fs, ax
        mov  gs, ax
        mov  ss, ax
        mov  cs, ax  ; toto neni dobry napad!!!

        wait_key
        exit
