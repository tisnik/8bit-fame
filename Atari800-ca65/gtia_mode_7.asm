; ---------------------------------------------------------------------
; Display list s mnoha různými textovými režimy.
; Postupná změna režimu na GTIA 9, 11 a 10.
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
fill_screen:
        sta screen, y           ; tisk znaku na zvolené místo na obrazovce
        clc
        adc #1
        iny                     ; zvětšit hodnotu počitadla a offsetu
        cpy #40*6               ; test na koncovou hodnotu počitadla
        bne fill_screen          ; skok, pokud Y>40*6

        lda #HUE_GREEN<<4 + 12  ; barva prvního hráče (odstín+intenzita)
        sta PCOLR0              ; uložit do řídicího registru PCOLR0 na čipu GTIA

        lda #HUE_YELLOW<<4 + 12 ; barva druhého hráče (odstín+intenzita)
        sta PCOLR1              ; uložit do řídicího registru PCOLR1 na čipu GTIA

        lda #HUE_MAGENTA<<4 + 12 ; barva třetího hráče (odstín+intenzita)
        sta PCOLR2              ; uložit do řídicího registru PCOLR2 na čipu GTIA

        lda #HUE_CYAN<<4 + 12   ; barva čtvrtého hráče (odstín+intenzita)
        sta PCOLR3              ; uložit do řídicího registru PCOLR3 na čipu GTIA

        jsr get_key             ; čekání na stisk klávesy

        lda GPRIOR              ; modifikace stínového registru GPRIOR
        ora  #$40               ; výběr GTIA režimu GR.9
        sta GPRIOR

        jsr get_key             ; čekání na stisk klávesy

        lda #15                 ; intenzita barev
        sta COLOR4              ; ulozit nový kód barvy do registru COLOR2

        lda GPRIOR              ; modifikace stínového registru GPRIOR
        ora  #$c0               ; výběr GTIA režimu GR.11
        sta GPRIOR

        jsr get_key             ; čekání na stisk klávesy

        lda #HUE_GREEN<<4 + 12  ; barva prvního hráče (odstín+intenzita)
        sta PCOLR0              ; uložit do řídicího registru PCOLR0 na čipu GTIA

        lda #HUE_YELLOW<<4 + 12 ; barva druhého hráče (odstín+intenzita)
        sta PCOLR1              ; uložit do řídicího registru PCOLR1 na čipu GTIA

        lda #HUE_MAGENTA<<4 + 12 ; barva třetího hráče (odstín+intenzita)
        sta PCOLR2              ; uložit do řídicího registru PCOLR2 na čipu GTIA

        lda #HUE_CYAN<<4 + 12   ; barva čtvrtého hráče (odstín+intenzita)
        sta PCOLR3              ; uložit do řídicího registru PCOLR3 na čipu GTIA

        lda GPRIOR              ; modifikace stínového registru GPRIOR
	and  #%00111111
        ora  #$80               ; výběr GTIA režimu GR.10
        sta GPRIOR

loop:   jmp loop
.endproc


; ---------------------------------------------------------------------
; čekání na stisk klávesy
; ---------------------------------------------------------------------
.proc get_key
        KBHANDLER = $e424       ; rutina pro cteni klavesy
        lda KBHANDLER+1         ; cteni horni casti adresy ulozene v ROM
        pha                     ; ulozeni na zasobnik
        lda KBHANDLER           ; cteni dolni casti adresy ulozene v ROM
        pha                     ; ulozeni na zasobnik
        rts                     ; vyber adresy ze zasobniku + skok
                                ; zde neni nutne mit RTS
.endproc


dlist:
.byte DL_BLK8, DL_BLK8, DL_BLK8 ; 3x8=24 prázdných obrazových řádků
.byte DL_LMS+DL_CHR20x16x2      ; určení počáteční adresy obrazové paměti + jeden řádek režimu 7
.byte <screen, >screen          ; počáteční adresa obrazové paměti 
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
.byte DL_CHR40x8x1              ; jeden řádek textového režimu 2 (GR.0)
.byte DL_CHR20x8x2              ; jeden řádek textového režimu 6 (GR.1)
.byte DL_CHR40x8x1              ; jeden řádek textového režimu 2 (GR.0)
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
.byte DL_MAP40x8x4              ; jeden řádek grafického režimu 8 (GR.3)
.byte DL_MAP40x8x4              ; jeden řádek grafického režimu 8 (GR.3)
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
.byte DL_CHR20x16x2             ; jeden řádek textového režimu 7 (GR.2)
.byte DL_CHR40x8x1              ; jeden řádek textového režimu 2 (GR.0)
.byte DL_JVB, <dlist, >dlist    ; skok na začátek display listu

end:

.BSS
screen: .res 20*24



.segment "EXEHDR"
.word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
.word   main                    ; zacatek kodoveho segmentu
.word   end - 1                 ; konec kodoveho segmentu


.segment "AUTOSTRT"             ; segment s pocatecni adresou
.word   RUNAD                   ; naplni se pouze adresy RUNAD a RUNAD+1
.word   RUNAD+1
.word   main                    ; adresa vstupniho bodu do programu

; finito
