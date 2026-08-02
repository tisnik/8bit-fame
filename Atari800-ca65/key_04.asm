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
loop:
        jsr get_key             ; načíst kód stisknuté klávesy
        jsr print_2_hex_digits  ; tisk kódu stiknuté klávesy
        jmp loop
.endproc



; ---------------------------------------------------------------------
; Tisk hodnoty 0..255 formou dvou hexadecimálních číslic
; ---------------------------------------------------------------------
.proc print_2_hex_digits
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



; ---------------------------------------------------------------------
; Převod hodnoty 0..15 na jeden hexadecimální znak
; ---------------------------------------------------------------------
.proc nibble_to_hex_char
        cmp #$0a                ; test na hodnotu 0-9 nebo 10-15
        bcc skip_add            ; je to hodnota 0-9
        adc #6                  ; pricist sedmicku (6+carry)
skip_add:
        adc #16                 ; prevod hodnoty na interni kod (ne ATASCII!)
        rts                     ; navrat z podprogramu
.endproc



; ---------------------------------------------------------------------
; Tisk znaku (v akumulátoru) na offset definovaný v index registru Y
; ---------------------------------------------------------------------
.proc print_char_at_y
        sta (88), y             ; tisk znaku na první místo na obrazovce
                                ; (adresa Video RAM je na adresách 88 a 89)
        rts
.endproc



; ---------------------------------------------------------------------
; Přečtení kódu naposledy stisknuté klávesy, kód se vrátí v registru A
; ---------------------------------------------------------------------
.proc get_key
        lda KBHANDLER+1         ; cteni horni casti adresy ulozene v ROM
        pha                     ; ulozeni na zasobnik
        lda KBHANDLER           ; cteni dolni casti adresy ulozene v ROM
        pha                     ; ulozeni na zasobnik
        rts                     ; vyber adresy ze zasobniku + skok
                                ; zde neni nutne mit RTS
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
