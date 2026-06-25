; ---------------------------------------------------------------------
; Vyplnění bloku náhodnými hodnotami.
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE


.proc main
loop:
        ldy #0                  ; počitadlo zápisů
fills:
        lda RANDOM
        sta (88), y             ; tisk znaku na zvolené místo na obrazovce
                                ; (adresa Video RAM je na adresách 88 a 89)
        iny                     ; zvětšit hodnotu počitadla a offsetu
        cpy #40*6               ; test na koncovou hodnotu počitadla
        bne fills               ; skok, pokud Y>40*6

        jsr get_key
        jmp loop
.endproc


; ---------------------------------------------------------------------
; čekání na stisk klávesy
; ---------------------------------------------------------------------
.proc get_key
        KBHANDLER = $e424       ; rutina pro cteni klavesy
        lda KBHANDLER+1         ; cteni horni casti adresy ulozene v ROM
        pha                     ; ulozeni na zasobnik
        lda KBHANDLER           ; cteni dolni casti adresy ulozene v ROM
        pha                     ; ulozeni na zasobnik
        rts                     ; vyber adresy ze zasobniku + skok
                                ; zde neni nutne mit RTS
.endproc


end:

.segment "EXEHDR"
.word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
.word   main                    ; zacatek kodoveho segmentu
.word   end - 1                 ; konec kodoveho segmentu


.segment "AUTOSTRT"             ; segment s pocatecni adresou
.word   RUNAD                   ; naplni se pouze adresy RUNAD a RUNAD+1
.word   RUNAD+1
.word   main                    ; adresa vstupniho bodu do programu

; finito
