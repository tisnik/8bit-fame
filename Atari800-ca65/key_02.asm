.include "atari.inc"

.CODE


.proc main
        lda #128                ; horizontální pozice prvního hráče
        sta HPOSP0              ; uložit do řídicího registru HPOSP0 na čipu GTIA

        lda #HUE_YELLOW<<4 + 12 ; barva prvního hráče (odstín+intenzita)
        sta PCOLR0              ; uložit do řídicího registru PCOLR0 na čipu GTIA

        lda #$ff                ; bitová maska prvního i druhého hráče
        sta GRAFP0              ; uložit do řídicího registru GRAFP0 na čipu GTIA

        lda #3                  ; bitové pole: povolení hráčů i střel
        sta GRACTL              ; uložit do řídicího registru GRACTL na čipu GTIA

        lda #152                ; paměťová stránka číslo 152
        sta PMBASE

        addr = 152*256
        ldx #8                  ; začneme na hodnotě o 1 vyšší
next_line:
        lda sprite-1, x         ; načíst
        sta addr+512+64, x      ; uložit byte
        dex                     ; snížit offset + nastavit příznaky
        bne next_line           ; další byte spritu

        lda #46                 ; povolení PMG DMA
        sta SDMCTL

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
        ldx x_pos               ; původní pozice prvního hráče

        lda STICK0              ; čtení joysticku
        cmp #11                 ; je nakloněn doleva?
        bne not_left
        dex                     ; posun hráče doleva
not_left:
        cmp #7                  ; je nakloněn doprava?
        bne not_right
        inx                     ; posun hráče doprava
not_right:
        stx HPOSP0              ; změna pozice prvního hráče
        stx x_pos               ; zapamatovat si pozici prvního hráče

        lda CONSOL              ; načtení stavu kláves START, SELECT, OPTION
        asl                     ; bitový posun doleva o pět bitů
        asl
        asl
        asl
        asl
        clc
        adc #12                 ; přidat požadovanou intenzitu
        sta PCOLR0              ; uložit do řídicího registru PCOLR0 na čipu GTIA

        jmp XITVBV              ; zpracovat zbytek odloženého VBLANKu
        rts
.endproc


; data
sprite:   .byte 24, 60, 126, 219, 255, 36, 90, 165

; pozice hráče
x_pos:    .byte 128

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
