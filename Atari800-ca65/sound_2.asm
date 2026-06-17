; ---------------------------------------------------------------------
; Generování zvuků čipem POKEY.
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE

PURE_TONE_MASK = %10100000
POLY_5_BIT_MASK = %01100000

; Frekvence CPU (PAL) = 1.7734470 MHz:
;     f_clk = 1773447 Hz
;
; Pokud je AUDCTL.0 nastaven na nulu, dělí se 28:
;     f_in = f_clk / 28 = 1773447 / 28 = 63337 Hz
;
; Pokud je AUDCTL.7 == 1 and AUDCTL.5 == 1, dělí se f_in dvěma
;     f_in_2 = f_in / 2 = 63337 / 2 = 31688 Hz
;
; Tato frekvence se přímo dělí obsahem registru AUDF1 (+1), takže pro #71:
;     f_out = f_in_2 / (71+1) = 31688 / 72 = 439 Hz
;
; S přimhouřením obou uší tedy dostaneme komorní A (440 Hz)

.proc main
        jsr get_key             ; čekání na stisk klávesy

        lda #PURE_TONE_MASK+10  ; hlasitost (0-15)
        sta AUDC1               ; zápis do registru řízení hlasitosti pro zvukový kanál číslo 1 čipu POKEY

        lda #71                 ; dělič základní frekvence
        sta AUDF1               ; zápis do registru děliče frekvence pro zvukový kanál číslo 1 čipu POKEY

        lda #00                 ; základní tón odvozený od 64kHz
        sta AUDCTL              ; zápis do řídicího registru čipu POKEY

        jsr get_key             ; čekání na stisk klávesy

        lda #POLY_5_BIT_MASK+10 ; hlasitost (0-15) + noise
        sta AUDC1               ; zápis do registru řízení hlasitosti pro zvukový kanál číslo 1 čipu POKEY

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
