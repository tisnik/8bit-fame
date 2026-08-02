.include "atari.inc"

KBHANDLER = $e424               ; rutina pro cteni klavesy

; ---------------------------------------------------------------------
; Definice maker
; ---------------------------------------------------------------------

.macro lsr_ shift_count
        .repeat shift_count
        lsr
        .endrep
.endmacro



.CODE

; ---------------------------------------------------------------------
; Hlavní program
; ---------------------------------------------------------------------
.proc main
        ; nastavit vektor pro BREAK
        lda #>break_handler
        sta BRKKY+1
        lda #<break_handler
        sta BRKKY
loop:
        jmp loop
.endproc



; ---------------------------------------------------------------------
; Subrutina pro obsluhu stisku klavesy BREAK
; ---------------------------------------------------------------------
.proc   break_handler
        lda #34                 ; kod znaku "B"
        ldy #1
        sta (88), y             ; tisk znaku na první místo na obrazovce
                                ; (adresa Video RAM je na adresách 88 a 89)
        rti
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
