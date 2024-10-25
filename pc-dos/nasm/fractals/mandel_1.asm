; asmsyntax=nasm
;
; Simple Mandelbrot set renderer
; 1st version (basic)
;
; .com size = 251 bytes
;
; Copyright (c) 1995-2014  Pavel Tisnovsky (tisnik)
; All rights reserved.
;
; Redistribution and use in source and binary forms, with or without
; modification, are permitted provided that the following conditions are met:
;     * Redistributions of source code must retain the above copyright
;       notice, this list of conditions and the following disclaimer.
;     * Redistributions in binary form must reproduce the above copyright
;       notice, this list of conditions and the following disclaimer in the
;       documentation and/or other materials provided with the distribution.
;     * Neither the name of the Red Hat nor the
;       names of its contributors may be used to endorse or promote products
;       derived from this software without specific prior written permission.
;
; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
; ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
; DISCLAIMED. IN NO EVENT SHALL Pavel Tisnovsky BE LIABLE FOR ANY
; DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
; ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;

bits 16

P       equ     65536           ;poloha desetinne tecky v X-pointu
K       equ     4*P/256         ;vzdalenost mezi dvema body (krok smycky)
K1      equ     4*P/192
MIN     equ     -2*P            ;minimalni a maximalni hodnota konstant fraktalu
                                ;v komplexni rovine



;-----------------------------------------------------------------------------
section .data

nadpis  db "  Pavel Tisnovsky  <tisnik@centrum.cz>$"

zy1     dd MIN                  ;poloha v komplexni rovine rovine



;-----------------------------------------------------------------------------
section .bss

zx1     resd 1                  ;
zx2     resd 1                  ;
zy2     resd 1                  ;aktualni poloha v komplexni rovine
zx3     resd 1                  ;zx3=zx2^2 (aby se to nemuselo pocitat 2x)
zy3     resd 1                  ;zy3=zy2^2



;-----------------------------------------------------------------------------
org     0x100
section .text

start:
        mov     ax,13h          ;gr.mod 13h
        int     10h

        lea     dx,[nadpis]
        mov     ah,9h
        int     21h             ;tisk nadpisu

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;: MANDELBROTOVA MNOZINA                                                    ::
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

        mov     AX,0a000h       ;
        mov     ES,AX           ;do ES zacatek obrazove pameti VGA
        mov     DI,320*8+32     ;zacatek vykreslovani na obrazovce
        mov     BP,192          ;BP==[x] fraktal bude velikosti 256x192
mforx:  mov     dword [zx1],MIN       ;od -2 (imaginarni osa)
        mov     SI,256          ;SI==[y]
mfory:  mov     CL,40           ;pocet iteraci
        xor     EAX,EAX         ;
        mov     dword [zx2],EAX ;nastaveni real.casti zacatku
        mov     dword [zy2],EAX ;nastaveni imag.casti zacatku
mrep_:                          ;*** iteracni smycka ***
        mov     EAX, dword [zx2];
        sar     EAX,8           ; 
        imul    EAX             ;ZX3:=ZX2^2 (v X-pointu)
        mov     dword [zx3],EAX ;
        mov     EAX,dword [zy2] ;
        sar     EAX,8           ; 
        imul    EAX             ;ZY3:=ZY2^2 (v X-pointu)
        mov     dword [zy3],EAX ;

        mov     EAX,[zx2]       ;
        sar     EAX,8           ;ZX2 div 256 (pro mul v X-pointu)
        mov     EBX,[zy2]       ;
        sar     EBX,7           ;ZY2 div 256 * 2 (pro mul v X-pointu)
        imul    EBX             ;ZY2:=2*ZX2*ZY2
        add     EAX,[zy1]       ;ZY2:=2*ZX2*ZY2+CY (u Mandelbrota poc.iter.)
        mov     [zy2],EAX       ;ulozit

        mov     EAX,[zx3]       ;
        sub     EAX,[zy3]       ;ZX3:=ZX3-ZY3=ZX2^2-ZY2^2
        add     EAX,[zx1]       ;
        mov     [zx2],EAX       ;ZX2:=ZX2^2-ZY2^2+CX
        dec     CL              ;pocitadlo iteraci
        jz      short mpokrac   ;konec iteraci ?
        mov     EAX,[zx3]       ;
        add     EAX,[zy3]       ;==ZX2^2+ZY2^2
        cmp     EAX,4*P         ;kontrola na bailout (abs[Z]<4)
        jc      short mrep_     ;abs[Z]<4 =>dalsi iterace
mpokrac:
        mov     AL,CL           ;pocet iteraci
        add     AL,32           ;posun na vhodne barvy v palete
        stosb                   ;vykreslit bod+posun na dalsi
        add     dword [zx1],K   ;ZY1:=ZY1+K
        dec     si
        jnz     mfory           ;Y!=0 ->dalsi radek
        add     DI,320-256      ;dalsi radek na obrazovce
        add     dword [zy1],K1  ;ZX1:=ZX1+K
        dec     BP              ;x=x-1
        jnz     mforx           ;X!=0 ->dalsi radek

opak01: mov     AH,1            ;sluzba BIOSu-cteni stavu bufferu klavesnice
        int     16h
        jz      short konec01   ;zadna klavesa v bufferu->konec
        xor     AH,AH           ;sluzba BIOSu-cteni klavesy z bufferu
        int     16h
        jmp     short opak01    ;dalsi klavesa
konec01:
        xor     AH,AH
        int     16h             ;cekani na klavesu
        mov     AX,3            ;gr.mod 3
        int     10h
        mov     AX,4c00h        ;navratovy kod=0
        int     21h             ;finito

; finito

