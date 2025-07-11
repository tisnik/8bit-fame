;-----------------------------------------------------------------------------
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Výpočty v systému pevné řádové čárky na platformě IBM PC (2. část)
; https://www.root.cz/clanky/vypocty-v-systemu-pevne-radove-carky-na-platforme-ibm-pc-2-cast/
;
;-----------------------------------------------------------------------------

org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

; konstanty
P       equ     4096*2             ; poloha desetinne tecky v X-pointu
K       equ     4*P/256            ; vzdalenost mezi dvema body (krok smycky)
L       equ     4*P/192
MIN     equ     -2*P               ; minimalni a maximalni hodnota konstant fraktalu
                                   ; v komplexni rovine
MAXITER equ     40                 ; maximalni pocet iteraci
BAILOUT equ     4
SLOUPCU equ     320                ; pocet sloupcu na obrazovce

section .text

start:
        jmp main                   ; skok na zacatek kodu

%include "io.asm"                  ; nacist symboly, makra a podprogramy


main:
        mov     ax, 13h            ; graficky rezim 320x200x256
        int     10h

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;: MANDELBROTOVA MNOZINA                                                    ::
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

        push    0xa000
        pop     ES                 ; segment obrazove pameti karty VGA

        xor     DI, DI             ; zacatek vykreslovani na obrazovce
        mov     CL, 7              ; posun pro FX format

mforx:  mov     word [cx_], MIN    ; od -2 (imaginarni osa)
        mov     SI, SLOUPCU        ; x
mfory:  mov     CH, MAXITER        ; pocet iteraci
        xor     AX, AX             ;
        mov     BP, AX             ; nastaveni real.casti zacatku
        mov     word [zy1], AX     ; nastaveni imag.casti zacatku
iter_loop:                         ; *** iteracni smycka ***
        mov     AX, BP             ;
        sar     AX, CL             ;
        imul    AX                 ; zx2:=zx1^2 (v X-pointu)
        mov     word [zx2], AX     ;
        mov     AX, [zy1]          ;
        sar     AX,CL              ;
        imul    AX                 ; zy2:=zy1^2 (v X-pointu)
        mov     word [zy2], AX     ;

        mov     AX, BP             ;
        sar     AX,CL              ; zx1 div 256 (pro mul v X-pointu)
        mov     BX, [zy1]          ;
        sar     BX,6               ; zy1 div 256 * 2 (pro mul v X-pointu)
        imul    BX                 ; zy1:=2*zx1*zy1
        add     AX, [cy_]          ; zy1:=2*zx1*zy1+CY (u Mandelbrota poc.iter.)
        mov     [zy1], AX          ; ulozit

        mov     AX, [zx2]          ;
        sub     AX, [zy2]          ; zx2:=zx2-zy2=zx1^2-zy1^2
        add     AX, [cx_]          ;
        mov     BP, AX             ; zx1:=zx1^2-zy1^2+CX
        dec     CH                 ; pocitadlo iteraci
        jz      short mpokrac      ; konec iteraci ?
        mov     AX, [zx2]          ;
        add     AX, [zy2]          ; ==zx1^2+zy1^2
        cmp     AX, BAILOUT*P      ; kontrola na bailout (abs[Z]<4)
        jc      short iter_loop    ; abs[Z]<4 =>dalsi iterace
mpokrac:
        mov     AL, CH             ; pocet iteraci
        add     AL, 32             ; posun na vhodne barvy v palete
        stosb                      ; vykreslit pixel+posun na dalsi pixel
        add     word [cx_], K      ; cy_:=cy_+K
        dec     si
        jnz     short mfory        ; Y!=0 ->dalsi radek

        add     word [cy_], L      ; cx_:=cx_+L
        cmp     di, 64000          ; konec obrazku ?
        jne     short mforx

finish:
        wait_key                   ; cekani na klavesu
        exit                       ; navrat do DOSu


section .data

cy_     dw MIN                     ; poloha v komplexni rovine rovine

section .bss

cx_     resw 1                     ;
zy1     resw 1                     ; aktualni poloha v komplexni rovine
zx2     resw 1                     ; zx2=zx1^2 (aby se to nemuselo pocitat 2x)
zy2     resw 1                     ; zy2=zy1^2



; finito
