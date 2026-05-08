; ---------------------------------------------------------------------
; Grafický režim 160x96 se čtyřmi barvami.
; 
; Tento zdrojový kód byl použit v článku:
;
; Praktické použití grafických režimů nabízených čipem ANTIC
; https://www.root.cz/clanky/prakticke-pouziti-grafickych-rezimu-nabizenych-cipem-antic/
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE


.proc main
        lda #$76                ; kod barvy
        sta COLOR0              ; ulozit do registru COLOR0

        lda #$34                ; kod barvy
        sta COLOR1              ; ulozit do registru COLOR1

        lda #$0c                ; kod barvy
        sta COLOR2              ; ulozit do registru COLOR2

        lda #$46                 ; kod barvy
        sta COLOR3              ; ulozit do registru COLOR3

        lda #<dlist             ; nižší byte adresy display listu
        sta SDLSTL
        lda #>dlist             ; vyšší byte adresy display listu
        sta SDLSTH

loop:   jmp loop
.endproc

dlist:
.byte DL_BLK8, DL_BLK8, DL_BLK8 ; 3x8=24 prázdných obrazových řádků
.byte DL_LMS+DL_MAP160x2x4      ; určení počáteční adresy obrazové paměti + jeden řádek režimu B (GR.6)
.byte <screen, >screen          ; počáteční adresa obrazové paměti 
.res 95, DL_MAP160x2x4          ; opakovat řádky grafického režimu B (GR.6)
.byte DL_JVB, <dlist, >dlist    ; skok na začátek display listu

screen:
.incbin "image_160x96x2.bin"
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
