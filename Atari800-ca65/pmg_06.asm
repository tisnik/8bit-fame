; ---------------------------------------------------------------------
; Initializace PMG, povolení PMG, nastavení pozice, tvaru a barvy dvou
; hráčů.
;
; Tento zdrojový kód byl použit v článku:
;
; Programování pro osmibitová Atari: čip GTIA a práce se sprity  
; https://www.root.cz/clanky/programovani-pro-osmibitova-atari-cip-gtia-a-prace-se-sprity/
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE

KBHANDLER = $e424               ; rutina pro cteni klavesy


.proc main
        lda #128                ; horizontální pozice prvního hráče
        sta HPOSP0              ; uložit do řídicího registru HPOSP0 na čipu GTIA

        lda #132                ; horizontální pozice druého hráče
        sta HPOSP1              ; uložit do řídicího registru HPOSP1 na čipu GTIA

        lda #HUE_GREEN<<4 + 6   ; barva prvního hráče (odstín+intenzita)
        sta PCOLR0              ; uložit do řídicího registru PCOLR0 na čipu GTIA

        lda #HUE_YELLOW<<4 + 12 ; barva druhého hráče (odstín+intenzita)
        sta PCOLR1              ; uložit do řídicího registru PCOLR1 na čipu GTIA

        lda #$ff                ; bitová maska prvního i druhého hráče
        sta GRAFP0              ; uložit do řídicího registru GRAFP0 na čipu GTIA
        sta GRAFP1              ; uložit do řídicího registru GRAFP1 na čipu GTIA

        lda #0                  ; bitové pole: vše nulové
        sta GRACTL              ; uložit do řídicího registru GRACTL na čipu GTIA

        lda #0                  ; priorita hráčů a pozadí
        sta GPRIOR              ; uložit do řídicího registru GPRIOR na čipu GTIA

        jsr get_key             ; čekání na stisk klávesy

        lda #32                 ; priorita hráčů a pozadí - OR barev
        sta GPRIOR              ; uložit do řídicího registru GPRIOR na čipu GTIA

        jsr get_key             ; čekání na stisk klávesy

        lda #31                 ; priorita hráčů a pozadí
        sta GPRIOR              ; uložit do řídicího registru GPRIOR na čipu GTIA

        jsr get_key             ; čekání na stisk klávesy

        lda #37                 ; priorita hráčů a pozadí
        sta GPRIOR              ; uložit do řídicího registru GPRIOR na čipu GTIA

loop:   jmp loop
.endproc

.proc get_key
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
