; ---------------------------------------------------------------------
; Initializace PMG, povolení PMG, nastavení pozice, tvaru a barvy prvního hráče.
; Zákaz DMA. Postupná změna horizontální velikosti hráče.
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
        lda #128                ; horizontální pozice hráče
        sta HPOSP0              ; uložit do řídicího registru HPOSP0 na čipu GTIA

        lda #HUE_MAGENTA<<4 + 8 ; barva hráče (odstín+intenzita)
        sta PCOLR0              ; uložit do řídicího registru PCOLR0 na čipu GTIA

        lda #128+32+8+2         ; bitová maska hráče
        sta GRAFP0              ; uložit do řídicího registru GRAFP0 na čipu GTIA

        lda #0                  ; bitové pole: vše nulové
        sta GRACTL              ; uložit do řídicího registru GRACTL na čipu GTIA

        jsr get_key             ; čekání na stisk klávesy

        lda #1                  ; horizontální velikost hráče
        sta SIZEP0              ; uložit do řídicího registru SIZEP0 na čipu GTIA

        jsr get_key             ; čekání na stisk klávesy

        lda #3                  ; horizontální velikost hráče
        sta SIZEP0              ; uložit do řídicího registru SIZEP0 na čipu GTIA

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
