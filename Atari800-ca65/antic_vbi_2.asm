; ---------------------------------------------------------------------
; Ovládání PMG joystickem v horizontálním směru.
; Aktivní čekání na dokončení vykreslování snímku.
;
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE

PLAYER_0_OFFSET = 512
PLAYER_1_OFFSET = PLAYER_0_OFFSET + 128
PLAYER_2_OFFSET = PLAYER_1_OFFSET + 128
PLAYER_3_OFFSET = PLAYER_2_OFFSET + 128


; ---------------------------------------------------------------------
; vstupní bod do programu
; ---------------------------------------------------------------------
.proc main
        lda #80                 ; horizontální pozice prvního hráče
        sta HPOSP0              ; uložit do řídicího registru HPOSP0 na čipu GTIA

        lda #100                ; horizontální pozice druhého hráče
        sta HPOSP1              ; uložit do řídicího registru HPOSP1 na čipu GTIA

        lda #120                ; horizontální pozice třetího hráče
        sta HPOSP2              ; uložit do řídicího registru HPOSP2 na čipu GTIA

        lda #140                ; horizontální pozice čtvrtého hráče
        sta HPOSP3              ; uložit do řídicího registru HPOSP3 na čipu GTIA

        lda #HUE_GREEN<<4 + 12  ; barva prvního hráče (odstín+intenzita)
        sta PCOLR0              ; uložit do řídicího registru PCOLR0 na čipu GTIA

        lda #HUE_YELLOW<<4 + 12 ; barva druhého hráče (odstín+intenzita)
        sta PCOLR1              ; uložit do řídicího registru PCOLR1 na čipu GTIA

        lda #HUE_MAGENTA<<4 + 12 ; barva třetího hráče (odstín+intenzita)
        sta PCOLR2              ; uložit do řídicího registru PCOLR2 na čipu GTIA

        lda #HUE_CYAN<<4 + 12   ; barva čtvrtého hráče (odstín+intenzita)
        sta PCOLR3              ; uložit do řídicího registru PCOLR3 na čipu GTIA

        lda #$ff                ; bitová maska všech hráčů
        sta GRAFP0              ; uložit do řídicího registru GRAFP0 na čipu GTIA
        sta GRAFP1              ; uložit do řídicího registru GRAFP1 na čipu GTIA
        sta GRAFP2              ; uložit do řídicího registru GRAFP2 na čipu GTIA
        sta GRAFP3              ; uložit do řídicího registru GRAFP3 na čipu GTIA

        lda #3                  ; bitové pole: povolení hráčů i střel
        sta GRACTL              ; uložit do řídicího registru GRACTL na čipu GTIA

        lda #0                  ; priorita hráčů a pozadí
        sta GPRIOR              ; uložit do řídicího registru GPRIOR na čipu GTIA

        lda #152                ; paměťová stránka číslo 152
        sta PMBASE

        addr = 152*256
        ldx #8                  ; začneme na hodnotě o 1 vyšší
next_line:
        lda sprite-1, x         ; načíst
        sta addr+PLAYER_0_OFFSET+50, x  ; uložit byte - první hráč
        sta addr+PLAYER_1_OFFSET+50, x  ; uložit byte - druhý hráč
        sta addr+PLAYER_2_OFFSET+50, x  ; uložit byte - třetí hráč
        sta addr+PLAYER_3_OFFSET+50, x  ; uložit byte - čtvrtý hráč
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
        jmp XITVBV              ; zpracovat zbytek odloženého VBLANKu
        rts
.endproc


; data
sprite:   .byte 24, 60, 126, 219, 255, 36, 90, 165

; horizontální pozice hráče
x_pos:    .byte 80

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
