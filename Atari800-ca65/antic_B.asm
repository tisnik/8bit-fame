; ---------------------------------------------------------------------
; Grafický režim 80x48 se dvěma barvami.
; 
; Tento zdrojový kód byl použit v článku:
;
; Praktické použití textových režimů nabízených čipem ANTIC
; https://www.root.cz/clanky/prakticke-pouziti-textovych-rezimu-nabizenych-cipem-antic/
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE


.proc main
        lda #<dlist             ; nižší byte adresy display listu
        sta SDLSTL
        lda #>dlist             ; vyšší byte adresy display listu
        sta SDLSTH

        ldy #0                  ; počitadlo zápisů
clear:
        tya                     ; kód tištěných pixelů
        sta screen, y           ; tisk pixelu na zvolené místo na obrazovce
        iny                     ; zvětšit hodnotu počitadla a offsetu
        bne clear               ; skok

loop:   jmp loop
.endproc

dlist:
.byte DL_BLK8, DL_BLK8, DL_BLK8 ; 3x8=24 prázdných obrazových řádků
.byte DL_LMS+DL_MAP80x4x2       ; určení počáteční adresy obrazové paměti + jeden řádek režimu 9 (GR.4)
.byte <screen, >screen          ; počáteční adresa obrazové paměti 
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_MAP80x4x2              ; jeden řádek grafického režimu 9 (GR.4)
.byte DL_JVB, <dlist, >dlist    ; skok na začátek display listu

end:

.BSS
screen: .res 10*48



.segment "EXEHDR"
.word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
.word   main                    ; zacatek kodoveho segmentu
.word   end - 1                ; konec kodoveho segmentu


.segment "AUTOSTRT"             ; segment s pocatecni adresou
.word   RUNAD                   ; naplni se pouze adresy RUNAD a RUNAD+1
.word   RUNAD+1
.word   main                    ; adresa vstupniho bodu do programu

; finito
