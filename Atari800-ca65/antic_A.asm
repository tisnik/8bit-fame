; ---------------------------------------------------------------------
; Výpis 256 kódů znaků v režimu GR.12. 
; Použití vlastní znakové sady (resp. její části).
; 
; Tento zdrojový kód byl použit v článku:
;
; Praktické použití textových režimů nabízených čipem ANTIC
; https://www.root.cz/clanky/prakticke-pouziti-textovych-rezimu-nabizenych-cipem-antic/
;
; Překlad do formátu xex:
; make antic_A.xex
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE

font_page = 152
font_target = 152 * 256

.proc main
        lda #font_page          ; vyšší bajt adresy fontu = číslo stránky
        sta CHBAS
        lda #<dlist             ; nižší byte adresy display listu
        sta SDLSTL
        lda #>dlist             ; vyšší byte adresy display listu
        sta SDLSTH

        ldy #0                  ; počitadlo zápisů
fill_screen:
        tya                     ; kód vypisovaného znaku
        sta screen, y           ; tisk znaku na zvolené místo na obrazovce
        iny                     ; zvětšit hodnotu počitadla a offsetu
        bne fill_screen         ; skok

define_font:
        ldx #8*8                ; počitadlo smyčky
next_line:
        lda font_source, x      ; načíst byte
        sta font_target, x      ; uložit byte
        dex                     ; snížit offset + nastavit příznaky
        bne next_line           ; další byte spritu
loop:   jmp loop
.endproc

dlist:
.byte DL_BLK8, DL_BLK8, DL_BLK8 ; 3x8=24 prázdných obrazových řádků
.byte DL_LMS+DL_CHR40x8x4       ; určení počáteční adresy obrazové paměti + jeden řádek režimu 4 (GR.12)
.byte <screen, >screen          ; počáteční adresa obrazové paměti 
.byte DL_CHR40x8x4              ; jeden řádek textového režimu 4 (GR.12)
.byte DL_CHR40x8x4              ; jeden řádek textového režimu 4 (GR.12)
.byte DL_CHR40x8x4              ; jeden řádek textového režimu 4 (GR.12)
.byte DL_CHR40x8x4              ; jeden řádek textového režimu 4 (GR.12)
.byte DL_CHR40x8x4              ; jeden řádek textového režimu 4 (GR.12)
.byte DL_CHR40x8x4              ; jeden řádek textového režimu 4 (GR.12)
.byte DL_CHR40x8x4              ; jeden řádek textového režimu 4 (GR.12)
.byte DL_CHR40x8x4              ; jeden řádek textového režimu 4 (GR.12)
.byte DL_CHR40x8x4              ; jeden řádek textového režimu 4 (GR.12)
.byte DL_CHR40x8x4              ; jeden řádek textového režimu 4 (GR.12)
.byte DL_CHR40x8x4              ; jeden řádek textového režimu 4 (GR.12)
.byte DL_JVB, <dlist, >dlist    ; skok na začátek display listu

font_source:
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000

.byte %01000000
.byte %01000000
.byte %01000000
.byte %01000000
.byte %01000000
.byte %01000000
.byte %01000000
.byte %01000000

.byte %10000000
.byte %10000000
.byte %10000000
.byte %10000000
.byte %10000000
.byte %10000000
.byte %10000000
.byte %10000000

.byte %11000000
.byte %11000000
.byte %11000000
.byte %11000000
.byte %11000000
.byte %11000000
.byte %11000000
.byte %11000000

.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000
.byte %00000000

.byte %01010101
.byte %01010101
.byte %01010101
.byte %01010101
.byte %01010101
.byte %01010101
.byte %01010101
.byte %01010101

.byte %10101010
.byte %10101010
.byte %10101010
.byte %10101010
.byte %10101010
.byte %10101010
.byte %10101010
.byte %10101010

.byte %11111111
.byte %11111111
.byte %11111111
.byte %11111111
.byte %11111111
.byte %11111111
.byte %11111111
.byte %11111111


end:


.BSS
screen: .res 40*24              ; rezervace prostoru pro video paměť



.segment "EXEHDR"
.word   $ffff                   ; úvodní sekvence bajtů v souboru ve formátu XEX
.word   main                    ; začátek kódového segmentu
.word   end - 1                 ; konec kódového segmentu



.segment "AUTOSTRT"             ; segment s počáteční adresou
.word   RUNAD                   ; naplní se pouze adresy RUNAD a RUNAD+1
.word   RUNAD+1
.word   main                    ; adresa vstupního bodu do programu

; finito
