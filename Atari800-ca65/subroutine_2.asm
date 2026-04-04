; ---------------------------------------------------------------------
; Definice subrutin, volání subrutiny s předáním parametru v registru.
;
; Tento zdrojový kód byl použit v článku:
;
; Programování pro osmibitová Atari: volání instrukcí procesoru MOS 6502
; https://www.root.cz/clanky/programovani-pro-osmibitova-atari-volani-instrukci-procesoru-mos-6502/
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE


.proc main
        lda #10                ; kod znaku, ktery se bude tisknout
        jsr print_char
loop:   jmp loop
.endproc


.proc print_char
        ldy #0                  ; vynulovat registr Y
        sta (88), y             ; tisk znaku na první místo na obrazovce
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
