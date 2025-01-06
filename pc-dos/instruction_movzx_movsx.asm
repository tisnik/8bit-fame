; Instrukcni soubor mikroprocesoru Intel 80386.
; Test instrukci pro konverzi dat.
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 386         ; specifikace pouziteho instrukcniho souboru

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        movzx bx, bl
        movzx ebx, bl
        movzx ebx, bx
        movzx bx, byte [start] 
        movzx ebx, word [start] 
        movsx bx, bl
        movsx ebx, bl
        movsx ebx, bx
        movsx bx, byte [start] 
        movsx ebx, word [start] 
