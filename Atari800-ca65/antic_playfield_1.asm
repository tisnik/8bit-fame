; ---------------------------------------------------------------------
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE



; ---------------------------------------------------------------------
; makro pro vyplnění obrazovky znaky
; ---------------------------------------------------------------------
.macro  fill_screen screen
        .local clear            ; definice lokálního symbolu
        ldy #0                  ; počitadlo zápisů
clear:
        tya                     ; kód vypisovaného znaku
        sta screen, y           ; tisk znaku na zvolené místo na obrazovce
        sta screen+40*8, y
        sta screen+40*16, y
        iny                     ; zvětšit hodnotu počitadla a offsetu
        cpy #$80
        bne clear               ; skok
.endmacro


; ---------------------------------------------------------------------
; makro pro nastavení display listu
; ---------------------------------------------------------------------
.macro  set_display_list label
        lda #<label             ; nižší byte adresy display listu
        sta SDLSTL
        lda #>label             ; vyšší byte adresy display listu
        sta SDLSTH
.endmacro


; ---------------------------------------------------------------------
; nastavení spodních dvou bitů stínového registru SDMCTL
; ---------------------------------------------------------------------
.macro  set_playfield_width bitfield
        lda SDMCTL              ; načíst stínový registr
        and #%11111100          ; vynulovat spodní dva bity
        ora  bitfield           ; nastavit spodní dva bity na zvolenou masku
        sta SDMCTL              ; a uložit zpět
.endmacro


; ---------------------------------------------------------------------
; hlavní herní smyčka
; ---------------------------------------------------------------------
.macro  game_loop
        .local loop             ; definice lokálního symbolu
loop:
        jmp loop                ; program vlastně nice nedělá - jen cyklí!
.endmacro


; ---------------------------------------------------------------------
; vstupní bod do programu
; ---------------------------------------------------------------------
.proc main
        set_display_list dlist  ; nastavení display listu
        fill_screen screen      ; výpis znaků na obrazovku

        jsr get_key             ; čekání na stisk klávesy

        set_playfield_width #%00
        jsr get_key             ; čekání na stisk klávesy

        set_playfield_width #%01
        jsr get_key             ; čekání na stisk klávesy

        set_playfield_width #%10
        jsr get_key             ; čekání na stisk klávesy

        set_playfield_width #%11

        game_loop               ; hlavní herní smyčka
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
