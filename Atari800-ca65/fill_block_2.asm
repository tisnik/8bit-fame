.include "atari.inc"

.CODE


.proc main
        lda #33                 ; kod znaku, ktery se bude tisknout
        ldy #40*5               ; počet zápisů
clear:
        sta (88), y             ; tisk znaku "A" na zvolené místo na obrazovce
                                ; (adresa Video RAM je na adresách 88 a 89)
        dey                     ; zmenšit hodnotu počitadla a offsetu
        bne clear               ; skok, pokud Y>0

loop:   jmp loop
end:
.endproc


.segment "EXEHDR"
.word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
.word   main                    ; zacatek kodoveho segmentu
.word   main::end - 1           ; konec kodoveho segmentu


.segment "AUTOSTRT"             ; segment s pocatecni adresou
.word   RUNAD                   ; naplni se pouze adresy RUNAD a RUNAD+1
.word   RUNAD+1
.word   main                    ; adresa vstupniho bodu do programu

; finito
