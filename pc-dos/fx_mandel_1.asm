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
P       equ     65536              ; poloha desetinne tecky v X-pointu
K       equ     4*P/256            ; vzdalenost mezi dvema body (krok smycky)
L       equ     4*P/192
MIN     equ     -2*P               ; minimalni a maximalni hodnota konstant fraktalu
                                   ; v komplexni rovine
MAXITER equ     40                 ; maximalni pocet iteraci
BAILOUT equ     4

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

        mov     DI, 320*8+32       ; zacatek vykreslovani na obrazovce
        mov     BP, 192            ; BP==[x] fraktal bude velikosti 256x192 pixelu
mforx:  mov     dword [cx_], MIN   ; od -2 (imaginarni osa)
        mov     SI, 256            ; SI==[y]
mfory:  mov     CL, MAXITER        ; maximalni pocet iteraci
        xor     EAX, EAX           ;
        mov     dword [zx1], EAX   ; nastaveni real.casti zacatku
        mov     dword [zy1], EAX   ; nastaveni imag.casti zacatku

iter_loop:                         ; *** iteracni smycka ***
        mov     EAX, dword [zx1]   ;
        sar     EAX, 8             ;
        imul    EAX                ; zx2:=zx1^2 (v X-pointu)
        mov     dword [zx2], EAX   ;

        mov     EAX, dword [zy1]   ;
        sar     EAX, 8             ;
        imul    EAX                ; zy2:=zy1^2 (v X-pointu)
        mov     dword [zy2], EAX   ;

        mov     EAX, [zx1]         ;
        sar     EAX, 8             ; zx1 div 256 (pro mul v X-pointu)

        mov     EBX, [zy1]         ;
        sar     EBX, 7             ; zy1 div 256 * 2 (pro mul v X-pointu)

        imul    EBX                ; zy1:=2*zx1*zy1
        add     EAX, [cy_]         ; zy1:=2*zx1*zy1+CY (u Mandelbrota poc.iter.)
        mov     [zy1], EAX         ; ulozit novou hodnotu zy1

        mov     EAX, [zx2]         ;
        sub     EAX, [zy2]         ; zx2:=zx2-zy2=zx1^2-zy1^2
        add     EAX, [cx_]         ;
        mov     [zx1], EAX         ; zx1:=zx1^2-zy1^2+CX

        dec     CL                 ; upravit pocitadlo iteraci
        jz      short mpokrac      ; konec iteraci ?
        mov     EAX, [zx2]         ;
        add     EAX, [zy2]         ; ==zx1^2+zy1^2
        cmp     EAX, BAILOUT*P     ; kontrola na bailout (abs[Z]<4)
        jc      short iter_loop    ; abs[Z]<4 =>dalsi iterace
mpokrac:
        mov     AL, CL             ; pocet iteraci
        add     AL, 32             ; posun na vhodne barvy v palete
        stosb                      ; vykreslit pixel+posun na dalsi pixel
        add     dword [cx_], K     ; cy_:=cy_+K
        dec     si
        jnz     mfory              ; Y!=0 ->dalsi radek
        add     DI, 320-256        ; dalsi radek na obrazovce
        add     dword [cy_], L     ; cx_:=cx_+K
        dec     BP                 ; x=x-1
        jnz     mforx              ; X!=0 ->dalsi radek

finish:
        wait_key                   ; cekani na klavesu
        exit                       ; navrat do DOSu


section .data

cy_     dd MIN                     ; poloha v komplexni rovine rovine

section .bss

cx_     resd 1                     ;
zx1     resd 1                     ;
zy1     resd 1                     ; aktualni poloha v komplexni rovine
zx2     resd 1                     ; zx2=zx1^2 (aby se to nemuselo pocitat 2x)
zy2     resd 1                     ; zy2=zy1^2



; finito
