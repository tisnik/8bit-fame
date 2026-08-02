.include "atari.inc"

.CODE


.proc main
        ; nastavit vektor pro odloženou VBI
        lda #>vbi_handler
        sta VVBLKD+1
        lda #<vbi_handler
        sta VVBLKD
loop:
        jmp loop                ; program vlastně nice nedělá - jen cyklí!
.endproc



; ---------------------------------------------------------------------
; tisk číslice uložené v akumulátoru na specifikovaný offset
; ---------------------------------------------------------------------
.macro print_digit offset
        clc
        adc #16                 ; převod na interní kód znaku
        ldy #offset             ; nastavit registr Y
        sta (88),y              ; tisk znaku "0" nebo "1" na specifikované místo na obrazovce
                                ; (adresa Video RAM je na adresách 88 a 89)
.endmacro



; ---------------------------------------------------------------------
; subrutina pro obsluhu VBI
; ---------------------------------------------------------------------
.proc   vbi_handler

        lda CONSOL              ; načtení stavu kláves START, SELECT, OPTION
        and #%00000001          ; jen klávesa START
        print_digit 2

        lda CONSOL              ; načtení stavu kláves START, SELECT, OPTION
        lsr
        and #%00000001          ; jen klávesa SELECT
        print_digit 4

        lda CONSOL              ; načtení stavu kláves START, SELECT, OPTION
        lsr
        lsr
        and #%00000001          ; jen klávesa OPTION
        print_digit 6

        jmp XITVBV              ; zpracovat zbytek odloženého VBLANKu
        rts
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
