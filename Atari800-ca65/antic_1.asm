; ---------------------------------------------------------------------
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
        cpy #40*6               ; test na koncovou hodnotu počitadla
        bne clear               ; skok, pokud Y>40*6

loop:   jmp loop
.endproc

dlist:
.byte 112, 112, 112
.byte 64+7, <screen, >screen
.byte 7, 7, 7, 7
.byte 7, 7, 7, 7
.byte 7, 7, 7
.byte 65, <dlist, >dlist

end:

.BSS
screen: .res 20*24



.segment "EXEHDR"
.word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
.word   main                    ; zacatek kodoveho segmentu
.word   end - 1                ; konec kodoveho segmentu


.segment "AUTOSTRT"             ; segment s pocatecni adresou
.word   RUNAD                   ; naplni se pouze adresy RUNAD a RUNAD+1
.word   RUNAD+1
.word   main                    ; adresa vstupniho bodu do programu

; finito
