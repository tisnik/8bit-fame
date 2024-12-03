; Instrukcni soubor mikroprocesoru Intel 80386.
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
        push cs
	push ds
	push ss
	push es
	push fs
	push gs

	pop  gs
	pop  fs
	pop  es
	pop  ss
	pop  ds
        pop  cs

        wait_key
        exit
