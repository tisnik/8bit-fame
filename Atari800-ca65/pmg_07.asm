; ---------------------------------------------------------------------
; Initializace PMG, nastavení barvy, pozice a bitmapy prvního hráče.
;
; Tento zdrojový kód byl použit v článku:
;
; 
; Programování pro osmibitová Atari: čip GTIA a práce se sprity  
; https://www.root.cz/clanky/programovani-pro-osmibitova-atari-cip-gtia-a-prace-se-sprity/
; ---------------------------------------------------------------------

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
        lda #24                 ; bitová maska jednoho řádku spritu
        sta addr+512+64         ; zapsat do paměti
        lda #60
        sta addr+512+64+1
        lda #126
        sta addr+512+64+2
        lda #126
        sta addr+512+64+3
        lda #219
        sta addr+512+64+4
        lda #255
        sta addr+512+64+5
        lda #36
        sta addr+512+64+6
        lda #90
        sta addr+512+64+7
        lda #165
        sta addr+512+64+8

        lda #46                 ; povolení PMG DMA
        sta SDMCTL

loop:   jmp loop
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
