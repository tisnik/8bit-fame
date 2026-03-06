.include "atari.inc"

.CODE

.proc main
        lda #33                 ; ATASCII hodnota znaku "A"
        ldy #0                  ; vynulovat registr Y
        sta (88),y              ; tisk znaku "A" na první místo na obrazovce
                                ; (adresa Video RAM je na adresách 88 a 89)
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
