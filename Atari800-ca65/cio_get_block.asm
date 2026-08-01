.include "atari.inc"

.CODE


.proc main
        ldx #0                  ; offset odvozený od čísla IOCB kanálu (nutno násobit šestnácti)
        lda #GETCHR             ; prováděná operace
        sta ICCOM, x

        ; adresa, na který se blok zapíše
        lda #<buffer
        sta ICBAL, x
        lda #>buffer
        sta ICBAH, x

        ; nastavení počtu čtených bajtů
        lda #(end_of_buffer-buffer)
        sta ICBLL, x
        lda #0
        sta ICBLH, x

        ; zavolání rutiny pro CIO
        jsr CIOV

        lda #18                 ; kod barvy
        sta COLOR2              ; ulozit do registru COLOR2
loop:
        jmp loop                ; program vlastně nice nedělá - jen cyklí!
.endproc

buffer: .res 10
end_of_buffer:

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
