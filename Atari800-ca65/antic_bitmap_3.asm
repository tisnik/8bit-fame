; ---------------------------------------------------------------------
; Grafický režim 160x96 se dvěma barvami.
; 
; Tento zdrojový kód byl použit v článku:
;
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE


.proc main
        lda #0                  ; kod barvy
        sta COLOR0              ; ulozit do registru COLOR2

        lda #10                 ; kod barvy
        sta COLOR4              ; ulozit do registru COLOR4

        lda #<dlist             ; nižší byte adresy display listu
        sta SDLSTL
        lda #>dlist             ; vyšší byte adresy display listu
        sta SDLSTH

loop:   jmp loop
.endproc

dlist:
.byte DL_BLK8, DL_BLK8, DL_BLK8 ; 3x8=24 prázdných obrazových řádků
.byte DL_LMS+DL_MAP160x2x2      ; určení počáteční adresy obrazové paměti + jeden řádek režimu B (GR.6)
.byte <screen, >screen          ; počáteční adresa obrazové paměti 
.res 95, DL_MAP160x2x2          ; opakovat řádky grafického režimu B (GR.6)
.byte DL_JVB, <dlist, >dlist    ; skok na začátek display listu

screen:
.include "image_160x96.asm"
end:



.segment "EXEHDR"
.word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
.word   main                    ; zacatek kodoveho segmentu
.word   end - 1                ; konec kodoveho segmentu


.segment "AUTOSTRT"             ; segment s pocatecni adresou
.word   RUNAD                   ; naplni se pouze adresy RUNAD a RUNAD+1
.word   RUNAD+1
.word   main                    ; adresa vstupniho bodu do programu

; finito
