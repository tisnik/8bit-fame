; ---------------------------------------------------------------------
; Výpis všech 128 znaků v přímé i inverzní podobě v režimu GR.0.
; Dočasná modifikace barvy pozadí provedená v DLI (dvanáctý textový řádek)
; 
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
        tya                     ; kód vypisovaného znaku
        sta screen, y           ; tisk znaku na zvolené místo na obrazovce
        sta screen+40*12, y
        iny                     ; zvětšit hodnotu počitadla a offsetu
        bne clear               ; skok

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
        pha                     ; uschovat akumulátor
        lda #$c4                ; barva pozadí
        sta COLPF2              ; přímo nastavit zápisem do HW registru
        pla                     ; obnovit akumulátor
        rti                     ; návrat z DLI


dlist:
.byte DL_BLK8, DL_BLK8, DL_BLK8 ; 3x8=24 prázdných obrazových řádků
.byte DL_LMS+DL_CHR40x8x1       ; určení počáteční adresy obrazové paměti + jeden řádek režimu 2 (GR.0)
.byte <screen, >screen          ; počáteční adresa obrazové paměti 
.res 10, DL_CHR40x8x1           ; opakovat řádky textového režimu 2 (GR.0)
.byte DL_DLI+DL_CHR40x8x1       ; GR.0 ovšem navíc s povolením DLI
.res 12, DL_CHR40x8x1           ; opakovat řádky textového režimu 2 (GR.0)
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
