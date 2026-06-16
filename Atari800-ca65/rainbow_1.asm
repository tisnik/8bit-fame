; ---------------------------------------------------------------------
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE


.proc main
        lda #<dlist             ; nižší byte adresy display listu
        sta SDLSTL
        lda #>dlist             ; vyšší byte adresy display listu
        sta SDLSTH

        ; vektor DLI
        lda #<dli               ; nastavení DLI
        sta VDSLST
        lda #>dli
        sta VDSLST+1

        ; povolení DLI
        NMIEN_DLI=$80           ; maska povolení DLI
        NMIEN_VBI=$40           ; maska povolení VBI
        lda #NMIEN_DLI | NMIEN_VBI ; povolení DLI
        sta NMIEN

loop:   jmp loop
.endproc


; ---------------------------------------------------------------------
; obsluha DLI
; ---------------------------------------------------------------------
dli:
        ldx #192                ; počitadlo řádků
next_line:
        stx COLPF2              ; změna barvy
        sta WSYNC               ; čekání na další řádek
        dex
        bne next_line           ; opakovat 192x
        rti                     ; návrat z DLI


dlist:
.byte DL_BLK8, DL_BLK8, DL_DLI+DL_BLK8 ; 3x8=24 prázdných obrazových řádků
.byte DL_LMS+DL_CHR40x8x1       ; určení počáteční adresy obrazové paměti + jeden řádek režimu 2 (GR.0)
.byte <screen, >screen          ; počáteční adresa obrazové paměti 
.res 23, DL_CHR40x8x1           ; opakovat řádky textového režimu 2 (GR.0)
.byte DL_JVB, <dlist, >dlist    ; skok na začátek display listu

end:

.BSS
screen: .res 40*24



.segment "EXEHDR"
.word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
.word   main                    ; zacatek kodoveho segmentu
.word   end - 1                 ; konec kodoveho segmentu


.segment "AUTOSTRT"             ; segment s pocatecni adresou
.word   RUNAD                   ; naplni se pouze adresy RUNAD a RUNAD+1
.word   RUNAD+1
.word   main                    ; adresa vstupniho bodu do programu

; finito
