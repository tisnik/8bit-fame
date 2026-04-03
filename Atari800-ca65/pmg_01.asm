; ---------------------------------------------------------------------
; Initializace PMG, povolení PMG, nastavení pozice a tvaru prvního hráče.
;
; Tento zdrojový kód byl použit v článku:
;
; 
; 
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE


.proc main
        lda #128                ; horizontální pozice hráče
        sta HPOSP0              ; uložit do řídicího registru HPOSP0 na čipu GTIA

        lda #$ff                ; bitová maska hráče
        sta GRAFP0              ; uložit do řídicího registru GRAFP0 na čipu GTIA

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
