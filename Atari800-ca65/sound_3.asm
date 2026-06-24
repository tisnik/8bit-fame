; ---------------------------------------------------------------------
; Generování zvuků čipem POKEY.
;
; Tento zdrojový kód byl použit v článku:
;
; Čip POKEY v osmibitových Atari: možnosti generování zvuků
; https://www.root.cz/clanky/cip-pokey-v-osmibitovych-atari-moznosti-generovani-zvuku/
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE

PURE_TONE_MASK   = %10100000
INPUT_FREQ_15KHZ = %00000001

.proc main
        jsr get_key             ; čekání na stisk klávesy

        lda #PURE_TONE_MASK+10  ; hlasitost (0-15)
        sta AUDC1               ; zápis do registru řízení hlasitosti pro zvukový kanál číslo 1 čipu POKEY

        lda #71                 ; dělič základní frekvence
        sta AUDF1               ; zápis do registru děliče frekvence pro zvukový kanál číslo 1 čipu POKEY

        lda #00                 ; základní tón odvozený od 64kHz
        sta AUDCTL              ; zápis do řídicího registru čipu POKEY

        jsr get_key             ; čekání na stisk klávesy

        lda #INPUT_FREQ_15KHZ   ; základní tón odvozený od 15kHz
        sta AUDCTL              ; zápis do řídicího registru čipu POKEY

        jsr get_key             ; čekání na stisk klávesy

        lda #0                  ; vypnutí zvuku (nulová hlasitost)
        sta AUDC1               ; zápis do registru řízení hlasitosti pro zvukový kanál číslo 1 čipu POKEY

loop:   jmp loop
.endproc


; ---------------------------------------------------------------------
; čekání na stisk klávesy
; ---------------------------------------------------------------------
.proc get_key
        KBHANDLER = $e424       ; rutina pro cteni klavesy
        lda KBHANDLER+1         ; cteni horni casti adresy ulozene v ROM
        pha                     ; ulozeni na zasobnik
        lda KBHANDLER           ; cteni dolni casti adresy ulozene v ROM
        pha                     ; ulozeni na zasobnik
        rts                     ; vyber adresy ze zasobniku + skok
                                ; zde neni nutne mit RTS
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
