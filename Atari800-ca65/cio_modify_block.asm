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

        ; modifikace obsahu bufferu
        ldx #0
next_char:
	lda buffer, x
	eor #%10000000          ; inverse video
	sta buffer, x
	inx
	cpx #(end_of_buffer-buffer)
	bne next_char

        ldx #0                  ; offset odvozený od čísla IOCB kanálu (nutno násobit šestnácti)
        lda #PUTCHR             ; prováděná operace
        sta ICCOM, x

        ; adresa zapisovaného bloku
        lda #<buffer
        sta ICBAL, x
        lda #>buffer
        sta ICBAH, x

        ; nastavení počtu zapisovaných bajtů
        lda #(end_of_buffer-buffer)
        sta ICBLL, x
        lda #0
        sta ICBLH, x

        ; zavolání rutiny pro CIO
        jsr CIOV
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
