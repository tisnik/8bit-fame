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

PURE_TONE_MASK = %10100000


.proc main
        lda #00                 ; základní tón odvozený od 64kHz
        sta AUDCTL              ; zápis do řídicího registru čipu POKEY

        lda #PURE_TONE_MASK+10  ; hlasitost (0-15)
        sta AUDC1               ; zápis do registru řízení hlasitosti pro zvukový kanál číslo 1 čipu POKEY

        ; nastavit vektor pro odloženou VBI
        lda #>horizontal_movement
        sta VVBLKD+1
        lda #<horizontal_movement
        sta VVBLKD
loop:
        jmp loop                ; program vlastně nice nedělá - jen cyklí!
.endproc


; ---------------------------------------------------------------------
; subrutina pro obsluhu VBI
; ---------------------------------------------------------------------
.proc   horizontal_movement
        ldx divider
        lda STICK0              ; čtení joysticku
        cmp #11                 ; je nakloněn doleva?
        bne not_left
        dex                     ; změna děliče
not_left:
        cmp #7                  ; je nakloněn doprava?
        bne not_right
        inx                     ; změna děliče
not_right:
        stx AUDF1               ; zápis do registru děliče frekvence pro zvukový kanál číslo 1 čipu POKEY
        stx divider
        jmp XITVBV              ; zpracovat zbytek odloženého VBLANKu
        rts
.endproc

; dělič frekvence
divider: .byte 71


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
