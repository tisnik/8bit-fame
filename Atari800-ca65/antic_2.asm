; ---------------------------------------------------------------------
; Nastavení display listu odpovídajícího textovému režimu GRAPHICS 2.
; Čitelnější varianta.
; 
; Tento zdrojový kód byl použit v článku:
;
; Grafika na osmibitových Atari: grafický koprocesor ANTIC
; https://www.root.cz/clanky/grafika-na-osmibitovych-atari-graficky-koprocesor-antic/
;
; Překlad do formátu xex:
; make antic_2.xex
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE


.proc main
        lda #<dlist             ; nižší byte adresy display listu
        sta SDLSTL
        lda #>dlist             ; vyšší byte adresy display listu
        sta SDLSTH

        ldy #0                  ; počitadlo zápisů
        lda #0                  ; kód vypisovaného znaku
clear:
        sta screen, y           ; tisk znaku na zvolené místo na obrazovce
        clc
        adc #1
        iny                     ; zvětšit hodnotu počitadla a offsetu
        cpy #20*12              ; test na koncovou hodnotu počitadla
        bne clear               ; skok, pokud Y>20x12

loop:   jmp loop
.endproc

dlist:
.byte DL_BLK8, DL_BLK8, DL_BLK8 ; 3x8=24 prázdných obrazových řádků
.byte DL_LMS+DL_CHR20x16x2      ; určení počáteční adresy obrazové paměti + jeden řádek režimu 7
.byte <screen, >screen          ; počáteční adresa obrazové paměti 
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
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
