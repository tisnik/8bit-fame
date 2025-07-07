;-----------------------------------------------------------------------------
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Výpočty v systému pevné řádové čárky na platformě IBM PC
; https://www.root.cz/clanky/vypocty-v-systemu-pevne-radove-carky-na-platforme-ibm-pc/
;
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

; konstanty
P       equ     65536                   ; poloha desetinne tecky v X-pointu
K       equ     4*P/128                 ; vzdalenost mezi dvema body (krok smycky)
MIN     equ     -2*P                    ; minimalni a maximalni hodnota konstant fraktalu

section .text

start:
        jmp main                        ; skok na zacatek kodu

%include "io.asm"                       ; nacist symboly, makra a podprogramy


main:
        mov     ax, 13h                 ; graficky rezim 320x200x256
        int     10h


        mov     CL,8
        push    0A000h                  ; do ES adresu video RAM
        pop     ES

OPAK:
        mov     DI,11520+96             ; aby se fraktal vykreslil
        mov     BP,52608-320+95
        mov     EAX, dword [CX_]        ; doprostred obrazovky
        add     EAX, dword [PCX]        ; posun konstanty
        mov     dword [CX_],EAX
        cmp     EAX,120000              ; kontrola CX_
        jg      short UP                ; CX_ osciluje mezi -100000 a 100000
        cmp     EAX,-120000
        jl      short UP
        jmp     short PP
UP:     neg     dword [PCX]             ; posun na opacnou stranu
        add     dword [CY_],6000        ; posun CY_
        cmp     dword [CY_],120000      ; kontrola CY_
        jl      short PP
        mov     dword [CY_],-80000
PP:
        mov     dword [ZX1],MIN
        mov     byte [X],64             ; fraktal bude velikosti 128x128
FORX:
        mov     dword [ZY1],MIN
        mov     byte [Y],128
FORY:
        mov     CH,16                   ; pocet iteraci
        mov     EAX, dword [ZX1]
        mov     dword [ZX2],EAX         ; ZX2:=ZX1
        mov     ESI, dword [ZY1]

REP_:
        mov     EAX, [ZX2]
        sar     EAX,CL                  ; ZX3:=ZX2^2
        imul    EAX
        mov     [ZX3],EAX

        mov     EAX,ESI
        sar     EAX,CL                  ; ZY3:=ZY2^2
        imul    EAX
        mov     [ZY3],EAX

        mov     EAX, [ZX2]
        sar     EAX,CL                  ; ZX2 div 256
        sar     ESI,7                   ; ZY2 div 256 * 2
        imul    ESI

        add     EAX, [CY_]               ; ZY2:=ZX2*ZY2+CY_
        mov     ESI,EAX

        mov     EAX, [ZX3]
        sub     EAX, [ZY3]
        add     EAX, [CX_]
        mov     [ZX2],EAX               ; ZX2:=ZX3^2-ZY3^2+CX_

        dec     CH                      ; pocitadlo iteraci
        jz      short POKRAC
        mov     EAX, [ZX3]
        add     EAX, [ZY3]
        cmp     EAX,4*P                 ; kontrola bailout
        jc      short REP_

POKRAC:
        mov     AL,CH                   ; pocet iteraci
        add     AL,16                   ; uprava barvy
        stosb                           ; vykreslit prvni bod
        mov     [ES:BP],AL              ; vykreslit druhy bod
        dec     BP
        add     dword [ZY1],K           ; ZY1:=ZY1+K
        dec     byte [Y]                ; Y:=Y-1
        jnz     short FORY
        add     DI,320-128              ; dalsi radek
        sub     BP,320-128
        add     dword [ZX1],K           ; ZX1:=ZX1+K
        dec     byte [X]                ; X:=X-1
        jnz     FORX

        mov     AH,01h                  ; je klavesa v bufferu ?
        int     16h
        jz      OPAK                    ; opakovat do stisku klavesy
finish:
        wait_key                        ; cekani na klavesu
        exit                            ; navrat do DOSu


section .data

CX_     dd -100000                      ; imaginarni konstanta pro iteraci
CY_     dd -80000
PCX     dd 6000                         ; posun realne casti konstanty


section .bss

X       resb  1                         ; pozice ve fraktalu
Y       resb  1
ZX1     resd  1                         ; komplexni cisla
ZY1     resd  1                         ; komplexni cisla
ZX2     resd  1                         ; komplexni cisla
ZY2     resd  1                         ; komplexni cisla
ZX3     resd  1                         ; komplexni cisla
ZY3     resd  1                         ; komplexni cisla



; finito
