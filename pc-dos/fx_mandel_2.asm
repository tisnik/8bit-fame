;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

; konstanty
P       equ     4096               ; poloha desetinne tecky v X-pointu
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
        mov     CL, 6              ; posun pro FX format

mforx:  mov     dword [zx1], MIN   ; od -2 (imaginarni osa)
        mov     SI, SLOUPCU        ; x
mfory:  mov     CH, MAXITER        ; pocet iteraci
        xor     EAX, EAX           ;
        mov     EBP, EAX           ; nastaveni real.casti zacatku
        mov     dword [zy2], EAX   ; nastaveni imag.casti zacatku
iter_loop:                         ; *** iteracni smycka ***
        mov     EAX, EBP           ;
        sar     EAX, CL            ;
        imul    EAX                ; ZX3:=ZX2^2 (v X-pointu)
        mov     dword [zx3], EAX   ;

        mov     EAX, dword [zy2]   ;
        sar     EAX, CL            ; 
        imul    EAX                ; ZY3:=ZY2^2 (v X-pointu)
        mov     dword [zy3], EAX   ;

        mov     EAX, EBP           ;
        sar     EAX, CL            ; ZX2 div 256 (pro mul v X-pointu)

        mov     EBX, [zy2]         ;
        sar     EBX, 5             ; ZY2 div 256 * 2 (pro mul v X-pointu)

        imul    EBX                ; ZY2:=2*ZX2*ZY2
        add     EAX, [zy1]         ; ZY2:=2*ZX2*ZY2+CY (u Mandelbrota poc.iter.)
        mov     [zy2], EAX         ; ulozit novou hodnotu ZY2

        mov     EAX, [zx3]         ;
        sub     EAX, [zy3]         ; ZX3:=ZX3-ZY3=ZX2^2-ZY2^2
        add     EAX, [zx1]         ;
        mov     EBP, EAX           ; ZX2:=ZX2^2-ZY2^2+CX

        dec     CH                 ; pocitadlo iteraci
        jz      short mpokrac      ; konec iteraci ?
        mov     EAX, [zx3]         ;
        add     EAX, [zy3]         ; ==ZX2^2+ZY2^2
        cmp     EAX, BAILOUT*P     ; kontrola na bailout (abs[Z]<4)
        jc      short iter_loop    ; abs[Z]<4 =>dalsi iterace
mpokrac:
        mov     AL, CH             ; pocet iteraci
        add     AL, 32             ; posun na vhodne barvy v palete
        stosb                      ; vykreslit pixel+posun na dalsi pixel
        add     dword [zx1], K     ; ZY1:=ZY1+K
        dec     si
        jnz     short mfory        ; Y!=0 ->dalsi radek

        add     dword [zy1], L     ; ZX1:=ZX1+K
        cmp     di, 64000          ; konec obrazku ?
        jne     mforx

finish:
        wait_key                   ; cekani na klavesu
        exit                       ; navrat do DOSu


section .data

zy1     dd MIN                     ; poloha v komplexni rovine rovine

section .bss

zx1     resd 1                     ;
zy2     resd 1                     ; aktualni poloha v komplexni rovine
zx3     resd 1                     ; zx3=zx2^2 (aby se to nemuselo pocitat 2x)
zy3     resd 1                     ; zy3=zy2^2



; finito
