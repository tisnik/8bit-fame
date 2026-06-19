; ---------------------------------------------------------------------
; Generování zvuků čipem POKEY.
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE

PURE_TONE_MASK     = %10100000
HIGH_PASS_1_3_MASK = %00000100

; Bit	Stručný popis
; 7	záměna 17bitového poly čítače za 9bitový čítač
; 6	vstupní hodinový signál pro kanál 1 bude mít frekvenci CPU (1,77 nebo 1,79 MHz)
; 5	vstupní hodinový signál pro kanál 3 bude mít frekvenci CPU (1,77 nebo 1,79 MHz)
; 4	vstupem kanálu číslo 2 bude kanál číslo 1 (spojení kanálů do 16bitového děliče)
; 3	vstupem kanálu číslo 4 bude kanál číslo 3 (spojení kanálů do 16bitového děliče)
; 2	konfigurace primitivní horní propusti pro kanál 1 tvořené kanálem 3
; 1	konfigurace primitivní horní propusti pro kanál 2 tvořené kanálem 4
; 0	vstupní hodinový signál bude mít frekvenci cca 15kHz a ne 64kHz



.proc main
        lda #PURE_TONE_MASK+10  ; hlasitost (0-15)
        sta AUDC1               ; zápis do registru řízení hlasitosti pro zvukový kanál číslo 1 čipu POKEY
        sta AUDC3               ; zápis do registru řízení hlasitosti pro zvukový kanál číslo 2 čipu POKEY

        lda #HIGH_PASS_1_3_MASK ; nastavení horní propusti
        sta AUDCTL              ; zápis do řídicího registru čipu POKEY

        ; nastavit vektor pro odloženou VBI
        lda #>horizontal_movement
        sta VVBLKD+1
        lda #<horizontal_movement
        sta VVBLKD
loop:
        lda noise1
        and #%111               ; jen spodní tři bity
        asl                     ; posunout do nejvyšších tří pozic
        asl
        asl
        asl
        asl
        clc
        adc #10                 ; přidat hlasitost
        sta AUDC1

        inc noise1
        jsr get_key             ; čekání na stisk klávesy
        jmp loop                ; program vlastně nice nedělá - jen cyklí!
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


; ---------------------------------------------------------------------
; subrutina pro obsluhu VBI
; ---------------------------------------------------------------------
.proc   horizontal_movement
        ldx divider1
        ldy divider2

        lda STICK0              ; čtení joysticku
        cmp #11                 ; je nakloněn doleva?
        bne not_left
        dex                     ; změna děliče
not_left:
        cmp #7                  ; je nakloněn doprava?
        bne not_right
        inx                     ; změna děliče
not_right:
        cmp #14                 ; je nakloněn nahoru?
        bne not_up
        dey                     ; změna Y-ové souřadnice hráče
not_up:
        cmp #13                 ; je nakloněn dolů?
        bne not_down
        iny                     ; změna Y-ové souřadnice hráče
not_down:
        stx AUDF1               ; zápis do registru děliče frekvence pro zvukový kanál číslo 1 čipu POKEY
        sty AUDF3               ; zápis do registru děliče frekvence pro zvukový kanál číslo 3 čipu POKEY
        stx divider1
        sty divider2
        jmp XITVBV              ; zpracovat zbytek odloženého VBLANKu
        rts
.endproc

; děliče frekvence
divider1: .byte 10
divider2: .byte 10
noise1:   .byte 0


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
