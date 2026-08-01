.include "atari.inc"

.CODE


.proc main
        ldx #0                  ; offset odvozený od čísla IOCB kanálu (nutno násobit šestnácti)
        lda #PUTCHR             ; prováděná operace
        sta ICCOM, x

        ; adresa zapisovaného bloku
        lda #<message
        sta ICBAL, x
        lda #>message
        sta ICBAH, x

        ; nastavení počtu zapisovaných bajtů na 256!!!
        lda #0
        sta ICBLL, x
        lda #1
        sta ICBLH, x

        ; zavolání rutiny pro CIO
        jsr CIOV

loop:
        jmp loop                ; program vlastně nice nedělá - jen cyklí!
.endproc

message: .byte "Hello, world!", $9b
end_of_message:

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
