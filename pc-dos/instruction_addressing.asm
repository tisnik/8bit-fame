; Instrukcni soubor mikroprocesoru Intel 8088 a Intel 8086
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------

BITS 16         ; 16bitovy vystup pro DOS
CPU 8086        ; specifikace pouziteho instrukcniho souboru

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        add ax, bx
        mov ax, [bx]
        mov ax, [si]
        mov ax, [di]
        mov ax, [bp]

        mov ax, [bx+0x1f]
        mov ax, [si+0x1f]
        mov ax, [di+0x1f]
        mov ax, [bp+0x1f]

        mov ax, [bx+0xeeff]
        mov ax, [si+0xeeff]
        mov ax, [di+0xeeff]
        mov ax, [bp+0xeeff]

        mov ax, [bp+si]
        mov ax, [bp+di]
        mov ax, [bp+si+0x1f]
        mov ax, [bp+di+0xeeff]
        mov al, 42
        mov ax, 42
        inc byte [123]
        inc word [123]
        inc byte [10000]
        inc word [10000]
