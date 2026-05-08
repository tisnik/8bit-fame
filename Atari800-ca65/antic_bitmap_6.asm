; ---------------------------------------------------------------------
; Grafický režim 320x192 se dvěma barvami.
; Zarovnání bitmapy do bloků 4096 bajtů.
; 
; Tento zdrojový kód byl použit v článku:
;
; Praktické použití grafických režimů nabízených čipem ANTIC
; https://www.root.cz/clanky/prakticke-pouziti-grafickych-rezimu-nabizenych-cipem-antic/
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE


.proc main
        lda #0                  ; kod barvy
        sta COLOR1              ; ulozit do registru COLOR4
        lda #14                 ; kod barvy
        sta COLOR2              ; ulozit do registru COLOR4

        lda #<dlist             ; nižší byte adresy display listu
        sta SDLSTL
        lda #>dlist             ; vyšší byte adresy display listu
        sta SDLSTH

loop:   jmp loop
.endproc

dlist:
.byte DL_BLK8, DL_BLK8, DL_BLK8 ; 3x8=24 prázdných obrazových řádků
.byte DL_LMS+DL_MAP320x1x1      ; určení počáteční adresy obrazové paměti + jeden řádek režimu F (GR.8)
.byte <screen, >screen          ; počáteční adresa obrazové paměti 
.res 191, DL_MAP320x1x1         ; opakovat řádky grafického režimu F (GR.8)
.byte DL_JVB, <dlist, >dlist    ; skok na začátek display listu


.segment "IMAGESEG"
.org $3000
screen:
.incbin "image_320x192.bin"

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
