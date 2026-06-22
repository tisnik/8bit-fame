; ---------------------------------------------------------------------
; Nastavení display listu odpovídajícího textovému režimu GRAPHICS 2.
; 
; Tento zdrojový kód byl použit v článku:
;
; Grafika na osmibitových Atari: grafický koprocesor ANTIC
; https://www.root.cz/clanky/grafika-na-osmibitovych-atari-graficky-koprocesor-antic/
;
; Překlad do formátu xex:
; make antic_1.xex
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE


.proc main
        lda #<dlist             ; nižší byte adresy display listu
        sta SDLSTL
        lda #>dlist             ; vyšší byte adresy display listu
        sta SDLSTH

        ldy #0                  ; počitadlo zápisů
        lda #0                  ; kód vypisovaného znaku
clear:
        sta screen, y           ; tisk znaku na zvolené místo na obrazovce
        clc
        adc #1
        iny                     ; zvětšit hodnotu počitadla a offsetu
        cpy #20*12              ; test na koncovou hodnotu počitadla
        bne clear               ; skok, pokud Y>20x12

loop:   jmp loop
.endproc

dlist:                          ; definice display listu
.byte 112, 112, 112
.byte 64+7, <screen, >screen
.byte 7, 7, 7, 7
.byte 7, 7, 7, 7
.byte 7, 7, 7
.byte 65, <dlist, >dlist

end:

.BSS
screen: .res 20*24              ; rezervace prostoru pro video paměť



.segment "EXEHDR"
.word   $ffff                   ; úvodní sekvence bajtů v souboru ve formátu XEX
.word   main                    ; začátek kódového segmentu
.word   end - 1                 ; konec kódového segmentu



.segment "AUTOSTRT"             ; segment s počáteční adresou
.word   RUNAD                   ; naplní se pouze adresy RUNAD a RUNAD+1
.word   RUNAD+1
.word   main                    ; adresa vstupního bodu do programu

; finito
