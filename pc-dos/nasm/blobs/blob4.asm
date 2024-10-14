; asmsyntax=nasm
;
; Simple blobs/metaballs renderer
; 2nd version (with simple greeting)
;
; .com size = 1820 bytes

bits 16



;-----------------------------------------------------------------------------
section .data

TABULKA:
        %include "blobdata.asm"

BLOB:
dw  30,  0,  1,  3,130, 40, -2,  3, 30, 10,  1, -1,230,  5,  2, -2
dw  30, 30,  2,  2, 60, 70, -1,  2,290, 50, -1, -1, 90, 20,  1, -1
dw  60, 30,  3,  1, 90, 30,  0,  1,150, 10,  1,  1,150, 40, -1,  0
dw 150, 60,  3,  3,150, 10,  1,  0,150, 30, -1,  1,180, 10, -2,  1
dw 180, 60,  2,  2,310, 10,  2, -1,210, 40,  1, -2,210, 50, -3,  2
dw 210, 20,  1,  1,210, 30, -1, -2

dw  20, 40, -2, -2,140, 10, -2,  2, 30, 20, -2, -3, 43, 40, -2,  3
dw  30, 30,  2, -2,280, 10,  2,  2,310, 60,  2, -3, 54, 50,  2,  3
dw  60, 40,  3, -2,180, 69,  3,  2

Y dw 0

typ_zk  db      "Simple  blob/metaballs renderer",13,10
        db      "",13,10
        db      "Author: Pavel Tisnovsky",13,10
        db      "(modified version prepared for NASM)",13,10
        db      "",13,10
        db      "welcome to x86 real mode :)",13,10
        db      "",13,10
        db      "...any key to quit..."

del_zk  dw      $-typ_zk



;-----------------------------------------------------------------------------
section .bss

BLOBOB  resw  4095



;-----------------------------------------------------------------------------
org     0x100
section .text

START:
;--- Nastaveni stacku a bufferu ---

        mov     AX,CS                   ;vzit code segment
        add     AX,1000h                ;posun o 64kB
        mov     ES,AX                   ;zde je BUFFER

;--- Nastaveni grafickeho modu a vymazani bufferu klavesnice ---

        mov     AX,13h                  ;graficky rezim
        int     10h

        mov     ax,1301h                ;tisk retezce
        mov     bx,0080h                ;barva
        mov     dh,17                   ;radek
        xor     dl,dl                   ;sloupec
        push    es
        push    ds
        pop     es
        mov     bp,typ_zk
        mov     cx,[del_zk]
        int     10h
        pop     es

;--- Povoleni kurzoru mysi a definice zakazane oblasti       ---

        xor     ax,ax                   ;sluzba
        int     33h
        mov     cx,0+30                 ;min
        mov     dx,640-30               ;max
        mov     ax,7                    ;horiz. range
        int     33h
        mov     cx,130                  ;min
        mov     dx,196                  ;max
        mov     ax,8                    ;vert. range
        int     33h
        mov     ax,1                    ;cursor on
        int     33h

OPAK:   mov     AH,01h                  ;zjistit, zda je klavesa v bufferu
        int     16h
        jz      KONEC
        xor     AH,AH                   ;precist buffer
        int     16h
        jmp     OPAK
KONEC:

;--- Vytvoreni bitmapy ---

        mov     DI,BLOBOB
        mov     BX,4095
 OO:                                    ;vymazani bitmapy
        mov     [DI+BX],byte 0          ;DS
        dec     BX
        jnz     OO

FORY:   xor     AX,AX
        push    AX
FORX:
        sub     AX,31                   ;sqr(X-31)
        imul    AX
        mov     CX,AX
        mov     AX,word [Y]
        sub     AX,31
        imul    AX
        add     AX,CX
        pop     BX
        push    BX
        shl     BX,6
        add     BX,word [Y]
        mov     DI,BLOBOB
        mov     SI,TABULKA
        cmp     AX,1022
        jnc     _ELSE
        mov     BP,AX
        mov     AL,[DS:SI+BP]
        mov     [DI+BX],AL              ;DS
        jmp     POK
_ELSE:  xor     AL,AL
        mov     [DI+BX],AL              ;DS
POK:    pop     AX
        inc     AX
        cmp     AX,63
        push    AX
        jnz     FORX
        inc     word [Y]
        cmp     word [Y],63
        jnz     FORY
        pop     AX

;--- Nastaveni palety ---

        xor     AH,AH
        xor     BX,BX
        mov     AL,63
        push    DS
        push    ES
        pop     DS
PALOPAK:
        mov     [BX],AL
        mov     [BX+1],byte 0
        mov     [BX+2],AH
        mov     [BX+64*3],AH
        mov     [BX+1+64*3],AH
        mov     [BX+2+64*3],AL
        mov     [BX+128*3],AL
        mov     [BX+1+128*3],byte 63
        mov     [BX+2+128*3],AH
        mov     [BX+64*3+128*3],byte 0
        mov     [BX+1+64*3+128*3],AL
        mov     [BX+2+64*3+128*3],AL
        inc     AH
        dec     AL
        add     BX,3
        cmp     BX,64*3-1
        jc      PALOPAK
        pop     DS

;--- Nastaveni palety pres BIOS

        mov     AX,1012H                ;sluzba 10h, podsluzba 12h
        xor     BX,BX                   ;offset prvni barvy
        mov     CX,255                  ;pocet barev
        xor     DX,DX
        int     10H                     ;volej BIOS
        cld

;*************************************************************************
;--- Hlavni smycka
C0:
        xor     BP,BP                   ;pocitadlo 0..31
FORD:   mov     DI,BLOB
        mov     BX,BP
        shl     BX,3                    ;D*8 (kazdy blob 8 byte)

        mov     AX,[DI+BX]              ;
        add     AX,[DI+BX+4]            ;posun X
        mov     [DI+BX],AX              ;
        mov     SI,AX                   ;X
        mov     AX,[DI+BX+2]            ;
        add     AX,[DI+BX+6]            ;posun Y
        mov     [DI+BX+2],AX            ;

;---Vykresleni blobu 63*63 do bufferu ---

        shl     AX,6
        mov     DI,AX                   ;ES:DI adresa bufferu
        shl     AX,2
        add     DI,AX
        add     DI,SI                   ;v DI je adresa X+Y*320
        xor     DX,DX
        mov     SI,BLOBOB               ;DS:SI offset dat

SMYC1:  mov     CX,64                   ;pocitadlo smycky 2
SMYC2:  lodsb                           ;nacteni barvy
        add     [ES:DI],AL              ;vykresleni bodu
        inc     DI                      ;dalsi bod
        dec     CX
        jnz     SMYC2                   ;jeden radek spocitany
        inc     DX                      ;pocitadlo vnejsi smycky
        add     DI,320-64               ;dalsi radek
        cmp     DX,63                   ;fsechny radky?
        jnz     SMYC1                   ;opakuj vnejsi smycku
        inc     BP                      ;dalsi blob
        cmp     BP,31
        jnz     FORD                    ;opakuj pro vsechny bloby

;---Buffer do obrazove pameti ---

        push    DS
        push    ES
        mov     AX,ES
        mov     DS,AX
        xor     SI,SI                   ;DS:SI adresa bufferu
        mov     AX,0A000h
        mov     ES,AX                   ;ES:DI adresa obrazove pameti
        xor     DI,DI
        mov     CX,320*130/4

        rep     movsd
        pop     ES
        pop     DS

;--- Smazat buffer ---

        xor     DI,DI                   ;ES:DI adresa bufferu
        mov     CX,320*130/4            ;pocet opakovani
        mov     EAX,0
        rep     stosd

;--- Zjisteni, zda byla stisknuta klavesa ---

        mov     AH,01h                  ;je klavesa v bufferu ?
        int     16h
        jz      C0

;--- Konec ---

        xor     AH,AH                   ;vymaz bufferu klavesnice
        int     16h
        mov     AX,03h                  ;textovy mod
        int     10h
        mov     AX,4c00h
        int     21h

