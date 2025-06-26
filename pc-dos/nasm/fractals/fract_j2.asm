; asmsyntax=nasm
;
; fract_j2.asm
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

P   equ 65536
K   equ 4*P/128
MIN equ -2*P



;-----------------------------------------------------------------------------
section .data

CX_     dd -100000                      ; imaginarni konstanta pro iteraci
CY_     dd -80000
PCX     dd 6000                         ; posun realne casti konstanty



;-----------------------------------------------------------------------------
section .bss

X       resb  1                         ; pozice ve fraktalu
Y       resb  1
ZX1     resd  1                         ; komplexni cisla
ZY1     resd  1                         ; komplexni cisla
ZX2     resd  1                         ; komplexni cisla
ZY2     resd  1                         ; komplexni cisla
ZX3     resd  1                         ; komplexni cisla
ZY3     resd  1                         ; komplexni cisla



;-----------------------------------------------------------------------------
org     0x100
section .text

START:
        mov     AX,13h                  ; graphics 320x200x256
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

        add     EAX, [CY_]              ; ZY2:=ZX2*ZY2+CY_
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
        xor     AH,AH                   ; cteni klavesy ->vymazani bufferu
        int     16h                     ; klavesnice
        mov     AX,3                    ; nastaveni textoveho rezimu
        int     10h
        retn                            ; konec

; finito

