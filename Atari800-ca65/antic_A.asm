; ---------------------------------------------------------------------
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
screen: .res 40*24



.segment "EXEHDR"
.word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
.word   main                    ; zacatek kodoveho segmentu
.word   end - 1                ; konec kodoveho segmentu


.segment "AUTOSTRT"             ; segment s pocatecni adresou
.word   RUNAD                   ; naplni se pouze adresy RUNAD a RUNAD+1
.word   RUNAD+1
.word   main                    ; adresa vstupniho bodu do programu

; finito
