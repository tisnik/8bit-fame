; ---------------------------------------------------------------------
; Generování zvuků čipem POKEY.
;
; Přímé přehrávání samplů.
; Použit je jen zvukový kanál číslo 1.
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE

.proc main
        jsr get_key             ; čekání na stisk klávesy

        lda #00                 ; základní tón odvozený od 64kHz + základní nastavení čtyř zvukových kanálů
        sta AUDCTL              ; zápis do řídicího registru čipu POKEY

        ldx #0                  ; vynulovat počitadlo
loop:
        lda delays, x           ; načtení doby trvání
        sta msc
l0:
        lda volumes, x          ; načtení amplitudy
        sta AUDC1               ; přímý zápis amplitudy (včetně bitu číslo 5)
        ldy tempo
l1:
        dey                     ; krátká zpožďovací smyčka
        bne l1
        dec msc
        bne l0                  ; vnější zpožďovací smyčka

        inx                     ; nový sampl
        cpx nc                  ; jsme na konci dat?
        bne loop                ; zatím ne - pokračujeme v přehrávání

        ldx #0                  ; začneme od začátku
        beq loop                ; když už je příznak nastavený, proč ho nevyužít
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


; čítač samplů
nc:
.byte 28

; tabulka amplitud
volumes:
.byte 24, 25, 26, 27, 28, 30, 31
.byte 30, 29, 28, 27, 26, 25, 24
.byte 23, 22, 21, 20, 19, 18, 17
.byte 18, 19, 20, 21, 22, 23, 24

; tabulka doby trvání amplitud
delays:
.byte 1, 1, 1, 2, 2, 2, 3
.byte 6, 3, 2, 2, 2, 1, 1
.byte 1, 1, 1, 2, 2, 2, 3
.byte 6, 3, 2, 2, 2, 1, 1

; vyšší hodnota - nižší tón
tempo:
.byte 1

; čítač vnější zpožďovací smyčky
msc:
.byte 0

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
