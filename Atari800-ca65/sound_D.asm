; ---------------------------------------------------------------------
; Generování zvuků čipem POKEY.
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE

PURE_TONE_MASK     = %10100000
POLY_4_BIT_MASK    = %11000000
POLY_5_BIT_MASK    = %01100000
POLY_17_BIT_MASK   = %10000000
POLY_4_5_BIT_MASK  = %01000000
POLY_17_5_BIT_MASK = %00000000
HIGH_PASS_1_3_MASK = %00000100

.proc main
        jsr get_key             ; čekání na stisk klávesy

        lda #PURE_TONE_MASK+10  ; hlasitost (0-15)
        sta AUDC1               ; zápis do registru řízení hlasitosti pro zvukový kanál číslo 1 čipu POKEY
        sta AUDC3               ; zápis do registru řízení hlasitosti pro zvukový kanál číslo 3 čipu POKEY

        lda #71                 ; dělič základní frekvence (komorní A: 440 Hz)
        sta AUDF1               ; zápis do registru děliče frekvence pro zvukový kanál číslo 1 čipu POKEY

        lda #31                 ; dělič základní frekvence (cca 1kHz)
        sta AUDF3               ; zápis do registru děliče frekvence pro zvukový kanál číslo 3 čipu POKEY

        lda #00                 ; základní tón odvozený od 64kHz
        sta AUDCTL              ; zápis do řídicího registru čipu POKEY

        jsr get_key             ; čekání na stisk klávesy

        lda #HIGH_PASS_1_3_MASK ; nastavení horní propusti
        sta AUDCTL              ; zápis do řídicího registru čipu POKEY

        jsr get_key             ; čekání na stisk klávesy
        lda #POLY_4_BIT_MASK+10  ; hlasitost (0-15)
        sta AUDC3               ; zápis do registru řízení hlasitosti pro zvukový kanál číslo 3 čipu POKEY

        jsr get_key             ; čekání na stisk klávesy
        lda #POLY_5_BIT_MASK+10  ; hlasitost (0-15)
        sta AUDC3               ; zápis do registru řízení hlasitosti pro zvukový kanál číslo 3 čipu POKEY

        jsr get_key             ; čekání na stisk klávesy
        lda #POLY_17_BIT_MASK+10  ; hlasitost (0-15)
        sta AUDC3               ; zápis do registru řízení hlasitosti pro zvukový kanál číslo 3 čipu POKEY

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
