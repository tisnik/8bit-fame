; ---------------------------------------------------------------------
; Makro pro logický posun doprava o zadaný počet bitů
;
; Tento zdrojový kód byl použit v článku:
;
; Programování pro osmibitová Atari: makra asm CA65, trik s instrukcí RTS
; https://www.root.cz/clanky/programovani-pro-osmibitova-atari-makra-asm-ca65-trik-s-instrukci-rts/
; ---------------------------------------------------------------------

.include "atari.inc"

; ---------------------------------------------------------------------
; Definice maker
; ---------------------------------------------------------------------

.macro lsr_ shift_count
        .repeat shift_count
	lsr
	.endrep
.endmacro



.CODE


.proc main
        lda #$42                ; cislo, ktere se bude tisknout
	jsr print_2_hex_digits  ; tisk dvouciferne hexadecimalni hodnoty
loop:   jmp loop
.endproc


.proc print_2_hex_digits
        ; TODO: ziskat jen vyssi cislici
	pha                     ; ulozit akumulator na zasobnik
	lsr_ 4                  ; posun 4 nejvyssich bitu do bitu nejnizsich
        jsr nibble_to_hex_char  ; prevod na interni kod cislice
	ldy #0                  ; pozice na obrazovce
        jsr print_char_at_y     ; tisk cislice/znaku

        pla
	and #$0f                ; ziskat jen nizsi nibble
        jsr nibble_to_hex_char  ; prevod na interni kod cislice
	ldy #1                  ; pozice na obrazovce
        jsr print_char_at_y     ; tisk cislice/znaku
.endproc


.proc nibble_to_hex_char
        cmp #$0a                ; test na hodnotu 0-9 nebo 10-15
        bcc skip_add            ; je to hodnota 0-9
        adc #6                  ; pricist sedmicku (6+carry)
skip_add:
        adc #16                 ; prevod hodnoty na interni kod (ne ATASCII!)
        rts                     ; navrat z podprogramu
.endproc


.proc print_char_at_y
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
