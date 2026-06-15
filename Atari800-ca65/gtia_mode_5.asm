; ---------------------------------------------------------------------
; Grafický režim 320x192 se dvěma barvami.
; Korektní display list.
; Vykreslení šestnácti různých kombinací pixelů.
; Přepnutí do GTIA režimu 11.
; Postupná změna intenzity všech barev.
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE

; dva bloky RAM využité jako obrazová paměť
screen1 = $7000
screen2 = $8000

; délka obrazového řádku v bajtech
scanline = 320/8


.proc main
        lda #<dlist             ; nižší byte adresy display listu
        sta SDLSTL
        lda #>dlist             ; vyšší byte adresy display listu
        sta SDLSTH

        lda #0                  ; zapisovaná hodnota + počitadlo smyčky
        tax                     ; offset do obrazové paměti
        clc                     ; nechceme přičítat přenos
draw:
        sta screen1, x          ; zápis na první řádek
        sta screen1+scanline, x ; buranský zápis do sedmi obrazových řádků pod sebe
        sta screen1+scanline*2, x  ; pozn: jde použít opakování přes makro
        sta screen1+scanline*3, x
        sta screen1+scanline*4, x
        sta screen1+scanline*5, x
        sta screen1+scanline*6, x
        sta screen1+scanline*7, x
        inx                     ; další zápis bude proveden o dva bajty dále
        inx
        adc #1                  ; zvýšení hodnoty v akumulátoru
        cmp #16                 ; konec smyčky?
        bne draw                ; dokud není nula, pokračovat

        lda GPRIOR              ; modifikace stínového registru GPRIOR
        ora  #$c0               ; výběr GTIA režimu GR.11
        sta GPRIOR


        ; postupná změna globálního odstínu (intenzity)
        lda #0                  ; barvový registr použití v režimu GR.9
next_color:
        sta COLOR4              ; ulozit nový kód barvy do registru COLOR2
	clc
	adc #1                  ; a zvýšit kód barvy pro další iteraci
	pha
        jsr get_key             ; čekání na stisk klávesy
	pla
	jmp next_color          ; změna barvy + další čekání na klávesu


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
.byte DL_LMS+DL_MAP320x1x1      ; určení počáteční adresy obrazové paměti + jeden řádek režimu F (GR.8)
.byte <screen1, >screen1        ; počáteční adresa obrazové paměti (první blok)
.res 95, DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_LMS+DL_MAP320x1x1      ; určení počáteční adresy obrazové paměti + jeden řádek režimu F (GR.8)
.byte <screen2, >screen2        ; počáteční adresa obrazové paměti (druhý blok)
.res 95, DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_JVB, <dlist, >dlist    ; skok na začátek display listu


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
