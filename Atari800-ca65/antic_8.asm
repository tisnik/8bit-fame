; ---------------------------------------------------------------------
; Výpis všech 64 znaků ve čtyřech barvách v režimu GR.1.
; Použití prvních 64 znaků z ATASCII.
; 
; Tento zdrojový kód byl použit v článku:
;
; Praktické použití textových režimů nabízených čipem ANTIC
; https://www.root.cz/clanky/prakticke-pouziti-textovych-rezimu-nabizenych-cipem-antic/
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE


.proc main
        lda #226                ; adresa se stránkou znakové sady
        sta CHBAS               ; uložit do řídicího registru ANTICu
        lda #<dlist             ; nižší byte adresy display listu
        sta SDLSTL
        lda #>dlist             ; vyšší byte adresy display listu
        sta SDLSTH

        ldy #0                  ; počitadlo zápisů
clear:
        tya                     ; kód vypisovaného znaku
        sta screen, y           ; tisk znaku na zvolené místo na obrazovce
        iny                     ; zvětšit hodnotu počitadla a offsetu
        bne clear               ; skok

loop:   jmp loop
.endproc

dlist:
.byte DL_BLK8, DL_BLK8, DL_BLK8 ; 3x8=24 prázdných obrazových řádků
.byte DL_LMS+DL_CHR20x8x2       ; určení počáteční adresy obrazové paměti + jeden řádek režimu 2 (GR.0)
.byte <screen, >screen          ; počáteční adresa obrazové paměti 
.byte DL_CHR20x8x2              ; jeden řádek textového režimu 6 (GR.1)
.byte DL_CHR20x8x2              ; jeden řádek textového režimu 6 (GR.1)
.byte DL_CHR20x8x2              ; jeden řádek textového režimu 6 (GR.1)
.byte DL_CHR20x8x2              ; jeden řádek textového režimu 6 (GR.1)
.byte DL_CHR20x8x2              ; jeden řádek textového režimu 6 (GR.1)
.byte DL_CHR20x8x2              ; jeden řádek textového režimu 6 (GR.1)
.byte DL_CHR20x8x2              ; jeden řádek textového režimu 6 (GR.1)
.byte DL_CHR20x8x2              ; jeden řádek textového režimu 6 (GR.1)
.byte DL_CHR20x8x2              ; jeden řádek textového režimu 6 (GR.1)
.byte DL_CHR20x8x2              ; jeden řádek textového režimu 6 (GR.1)
.byte DL_CHR20x8x2              ; jeden řádek textového režimu 6 (GR.1)
.byte DL_CHR20x8x2              ; jeden řádek textového režimu 6 (GR.1)
.byte DL_CHR20x8x2              ; jeden řádek textového režimu 6 (GR.1)
.byte DL_JVB, <dlist, >dlist    ; skok na začátek display listu

end:

.BSS
screen: .res 20*24



.segment "EXEHDR"
.word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
.word   main                    ; zacatek kodoveho segmentu
.word   end - 1                ; konec kodoveho segmentu


.segment "AUTOSTRT"             ; segment s pocatecni adresou
.word   RUNAD                   ; naplni se pouze adresy RUNAD a RUNAD+1
.word   RUNAD+1
.word   main                    ; adresa vstupniho bodu do programu

; finito
