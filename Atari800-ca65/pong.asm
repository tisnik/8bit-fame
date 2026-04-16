; ---------------------------------------------------------------------
; Zobrazení obrazovky ze hry Pong.
;
; Tento zdrojový kód byl použit v článku:
;
; Grafika na osmibitových Atari: grafický koprocesor ANTIC
; https://www.root.cz/clanky/grafika-na-osmibitovych-atari-graficky-koprocesor-antic/
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE

SCORE_OFFSET = 10
PLAYER_0_OFFSET = 512
PLAYER_1_OFFSET = PLAYER_0_OFFSET + 128
PLAYER_2_OFFSET = PLAYER_1_OFFSET + 128
PLAYER_3_OFFSET = PLAYER_2_OFFSET + 128
MISSILES_OFFSET = 384


.proc main
        lda #0                  ; barva pozadí textu
        sta COLOR1              ; nastavit
        sta COLOR2              ; nastavit

        lda #70                 ; horizontální pozice prvního hráče (číslice skóre)
        sta HPOSP0              ; uložit do řídicího registru HPOSP0 na čipu GTIA

        lda #80                 ; horizontální pozice druhého hráče (číslice skóre)
        sta HPOSP1              ; uložit do řídicího registru HPOSP1 na čipu GTIA

        lda #160                ; horizontální pozice třetího hráče (číslice skóre)
        sta HPOSP2              ; uložit do řídicího registru HPOSP2 na čipu GTIA

        lda #170                ; horizontální pozice čtvrtého hráče (číslice skóre)
        sta HPOSP3              ; uložit do řídicího registru HPOSP3 na čipu GTIA

        lda #50                 ; horizontální pozice první střely (pálka)
        sta HPOSM0              ; uložit do řídicího registru HPOSM0 na čipu GTIA

        lda #200                ; horizontální pozice druhé střely (pálka)
        sta HPOSM1              ; uložit do řídicího registru HPOSM1 na čipu GTIA

        lda #160                ; horizontální pozice třetí střely (míček)
        sta HPOSM2              ; uložit do řídicího registru HPOSM2 na čipu GTIA

        lda #128                ; horizontální pozice čtvrté střely (síťka)
        sta HPOSM3              ; uložit do řídicího registru HPOSM3 na čipu GTIA

        lda #HUE_GREEN<<4 + 12  ; barva prvního hráče (odstín+intenzita)
        sta PCOLR0              ; uložit do řídicího registru PCOLR0 na čipu GTIA

        lda #HUE_YELLOW<<4 + 12 ; barva druhého hráče (odstín+intenzita)
        sta PCOLR1              ; uložit do řídicího registru PCOLR1 na čipu GTIA

        lda #HUE_MAGENTA<<4 + 12 ; barva třetího hráče (odstín+intenzita)
        sta PCOLR2              ; uložit do řídicího registru PCOLR2 na čipu GTIA

        lda #HUE_CYAN<<4 + 12   ; barva čtvrtého hráče (odstín+intenzita)
        sta PCOLR3              ; uložit do řídicího registru PCOLR3 na čipu GTIA

        lda #3                  ; bitové pole: povolení hráčů i střel
        sta GRACTL              ; uložit do řídicího registru GRACTL na čipu GTIA

        lda #0                  ; priorita hráčů a pozadí
        sta GPRIOR              ; uložit do řídicího registru GPRIOR na čipu GTIA

        lda #152                ; paměťová stránka číslo 152
        sta PMBASE

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;; Skóre
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        addr = 152*256
        ldx #8                  ; začneme na hodnotě o 1 vyšší
next_line:
        lda number_0-1, x         ; načíst
        sta addr+PLAYER_0_OFFSET+SCORE_OFFSET, x  ; uložit byte - první hráč
        sta addr+PLAYER_1_OFFSET+SCORE_OFFSET, x  ; uložit byte - druhý hráč
        sta addr+PLAYER_2_OFFSET+SCORE_OFFSET, x  ; uložit byte - třetí hráč
        sta addr+PLAYER_3_OFFSET+SCORE_OFFSET, x  ; uložit byte - čtvrtý hráč
        dex                     ; snížit offset + nastavit příznaky
        bne next_line           ; další byte spritu

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;; Pálky
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ldx #20
missile_line:
        lda #%0000001           ; jen první střela (pálka)
        sta addr+MISSILES_OFFSET+50, x
        lda #%0000100           ; jen druhá střela (pálka)
        sta addr+MISSILES_OFFSET+72, x
        dex
        bne missile_line        ; další byte spritu

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;; Míček
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        lda #%00110000          ; jen třetí střela (míček)
        sta addr+MISSILES_OFFSET+70, x
        sta addr+MISSILES_OFFSET+71, x

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;; Síťka
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ldx #126
net:
        lda addr+MISSILES_OFFSET, x
        ora #%1000000           ; jen čtvrtá střela (síťka)
        sta addr+MISSILES_OFFSET, x
        dex
        dex
        bne net                 ; další byte spritu

        lda #46                 ; povolení PMG DMA
        sta SDMCTL

loop:   jmp loop
.endproc

; data
number_0: .byte %00111100, %011000011, %011000011, %011000011, %011000011, %011000011, %00111100, 0

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
