; ---------------------------------------------------------------------
; Initializace PMG, povolení PMG, nastavení pozice, tvaru a barvy prvního hráče.
; Zákaz DMA.
;
; Tento zdrojový kód byl použit v článku:
;
; Programování pro osmibitová Atari: čip GTIA a práce se sprity  
; https://www.root.cz/clanky/programovani-pro-osmibitova-atari-cip-gtia-a-prace-se-sprity/
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE


.proc main
        lda #128                ; horizontální pozice hráče
        sta HPOSP0              ; uložit do řídicího registru HPOSP0 na čipu GTIA

        lda #HUE_MAGENTA<<4 + 8 ; barva hráče (odstín+intenzita)
        sta PCOLR0              ; uložit do řídicího registru PCOLR0 na čipu GTIA

        lda #$ff                ; bitová maska hráče
        sta GRAFP0              ; uložit do řídicího registru GRAFP0 na čipu GTIA

        lda #0                  ; bitové pole: vše nulové
        sta GRACTL              ; uložit do řídicího registru GRACTL na čipu GTIA

loop:   jmp loop
end:
.endproc


.segment "EXEHDR"
.word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
.word   main                    ; zacatek kodoveho segmentu
.word   main::end - 1           ; konec kodoveho segmentu


.segment "AUTOSTRT"             ; segment s pocatecni adresou
.word   RUNAD                   ; naplni se pouze adresy RUNAD a RUNAD+1
.word   RUNAD+1
.word   main                    ; adresa vstupniho bodu do programu

; finito
