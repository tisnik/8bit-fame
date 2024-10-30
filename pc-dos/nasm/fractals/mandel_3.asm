; asmsyntax=nasm
;
; Simple Mandelbrot set renderer
; 3rd version (16bit calculation with overflows in some areas)
;
; .com size = 138 bytes

bits 16

P       equ     4096            ;poloha desetinne tecky v X-pointu
K       equ     3*P/320         ;vzdalenost mezi dvema body (krok smycky)
L       equ     3*P/240
MIN     equ     -2*P            ;minimalni a maximalni hodnota konstant fraktalu
                                ;v komplexni rovine
ITERACI equ     40              ;pocet iteraci
SLOUPCU equ     320             ;pocet sloupcu na obrazovce



;-----------------------------------------------------------------------------
section .data

zy1     dw -1*P-1000            ;poloha v komplexni rovine rovine

;-----------------------------------------------------------------------------
section .bss

zx1     resw 1                  ;
zy2     resw 1                  ;aktualni poloha v komplexni rovine
zx3     resw 1                  ;zx3=zx2^2 (aby se to nemuselo pocitat 2x)
zy3     resw 1                  ;zy3=zy2^2



;-----------------------------------------------------------------------------
org     0x100
section .text

start:
        mov     ax,13h          ;gr.mod 13h
        int     10h

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;: MANDELBROTOVA MNOZINA                                                    ::
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

        push    0a000h
        pop     ES
        xor     DI,DI           ;zacatek vykreslovani na obrazovce
        mov     CL,6            ;poloha desetinne tecky v x-pointu

mforx:  mov     word [zx1],MIN  ;od -2 (imaginarni osa)
        mov     SI,SLOUPCU      ;x
mfory:  mov     CH,ITERACI      ;pocet iteraci
        xor     AX,AX           ;
        mov     BP,AX           ;nastaveni real.casti zacatku
        mov     word [zy2],AX   ;nastaveni imag.casti zacatku
mrep_:                          ;*** iteracni smycka ***
        mov     AX,BP           ;
        sar     AX,CL           ;
        imul    AX              ;ZX3:=ZX2^2 (v X-pointu)
        mov     word [zx3],AX   ;
        mov     AX,[zy2]        ;
        sar     AX,CL           ;
        imul    AX              ;ZY3:=ZY2^2 (v X-pointu)
        mov     word [zy3],AX   ;

        mov     AX, BP          ;
        sar     AX,CL           ;ZX2 div 256 (pro mul v X-pointu)
        mov     BX,[zy2]        ;
        sar     BX,5            ;ZY2 div 256 * 2 (pro mul v X-pointu)
        imul    BX              ;ZY2:=2*ZX2*ZY2
        add     AX,[zy1]        ;ZY2:=2*ZX2*ZY2+CY (u Mandelbrota poc.iter.)
        mov     [zy2], AX       ;ulozit

        mov     AX,[zx3]        ;
        sub     AX,[zy3]        ;ZX3:=ZX3-ZY3=ZX2^2-ZY2^2
        add     AX,[zx1]        ;
        mov     BP, AX          ;ZX2:=ZX2^2-ZY2^2+CX
        dec     CH              ;pocitadlo iteraci
        jz      short mpokrac   ;konec iteraci ?
        mov     AX,[zx3]        ;
        add     AX,[zy3]        ;==ZX2^2+ZY2^2
        cmp     AX,4*P          ;kontrola na bailout (abs[Z]<4)
        jc      short mrep_     ;abs[Z]<4 =>dalsi iterace
mpokrac:
        mov     AL,CH           ;pocet iteraci
        add     AL,32           ;posun na vhodne barvy v palete
        stosb                   ;vykreslit bod+posun na dalsi
        add     word [zx1],K    ;ZY1:=ZY1+K
        dec     si
        jnz     short mfory     ;Y!=0 ->dalsi radek

        add     word [zy1],L    ;ZX1:=ZX1+L
        cmp     di,64000        ;konec obrazku ?
        jne     short mforx

        mov     AX,0c07h        ;cekat na klavesu
        int     21h
        mov     AX,3            ;textovy rezim
        int     10h
        retn                    ;finito

