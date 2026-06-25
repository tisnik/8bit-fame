; ---------------------------------------------------------------------
; Vyplnění bloku náhodnými hodnotami.
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

        jsr get_key

loop:
        ldy #0                  ; počitadlo zápisů
fills:
        lda RANDOM
        sta screen, y           ; tisk znaku na zvolené místo na obrazovce
        iny                     ; zvětšit hodnotu počitadla a offsetu
        cpy #40*6               ; test na koncovou hodnotu počitadla
        bne fills               ; skok, pokud Y>40*6

        jsr get_key
        jmp loop
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
.byte DL_LMS+DL_MAP80x4x2       ; určení počáteční adresy obrazové paměti + jeden řádek režimu 9 (GR.4)
.byte <screen, >screen          ; počáteční adresa obrazové paměti 
.res 47, DL_MAP80x4x2           ; opakovat řádky grafického režimu 9 (GR.4)
.byte DL_JVB, <dlist, >dlist    ; skok na začátek display listu

screen:                         ; video paměť
.include "image_80x48.asm"

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
