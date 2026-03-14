.include "atari.inc"

.CODE


.proc main
        lda #99                 ; cislo, ktere se bude tisknout
	jsr print_2_hex_digits  ; tisk dvouciferne hexadecimalni hodnoty
loop:   jmp loop
.endproc


.proc print_2_hex_digits
        ; TODO: ziskat jen vyssi cislici
        jsr nibble_to_hex_char  ; prevod na interni kod cislice
	; TODO: urceni relativniho mista na obrazovce
        jsr print_char          ; tisk cislice/znaku

        ; TODO: ziskat jen nizsi cislici
        jsr nibble_to_hex_char  ; prevod na interni kod cislice
	; TODO: urceni relativniho mista na obrazovce
        jsr print_char          ; tisk cislice/znaku
.endproc


.proc nibble_to_hex_char
        cmp #$0a                ; test na hodnotu 0-9 nebo 10-15
        bcc skip_add            ; je to hodnota 0-9
        adc #6                  ; pricist sedmicku (6+carry)
skip_add:
        adc #16                 ; prevod hodnoty na interni kod (ne ATASCII!)
        rts                     ; navrat z podprogramu
.endproc


.proc print_char
        ldy #0                  ; vynulovat registr Y
        sta (88), y             ; tisk znaku na první místo na obrazovce
                                ; (adresa Video RAM je na adresách 88 a 89)
        rts
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
