.include "atari.inc"

.CODE


.proc main
        lda #9                  ; cislo, ktere se bude tisknout
        jsr hex_digit
loop:   jmp loop
.endproc


.proc hex_digit
        clc                     ; vymazat priznak prenosu
        adc #16                 ; prevod hodnoty na interni kod (ne ATASCII!)
        ldy #0                  ; vynulovat registr Y
        sta (88), y             ; tisk znaku na první místo na obrazovce
                                ; (adresa Video RAM je na adresách 88 a 89)
        rts                     ; navrat z podprogramu
.endproc

end:                            ; potrebujeme znat adresu konce kodoveho segmentu


.segment "EXEHDR"
.word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
.word   main                    ; zacatek kodoveho segmentu
.word   end - 1                 ; konec kodoveho segmentu


.segment "AUTOSTRT"             ; segment s pocatecni adresou
.word   RUNAD                   ; naplni se pouze adresy RUNAD a RUNAD+1
.word   RUNAD+1
.word   main                    ; adresa vstupniho bodu do programu

; finito
