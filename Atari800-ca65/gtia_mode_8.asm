; ---------------------------------------------------------------------
; Grafický režim 320x192 se dvěma barvami.
; Korektní display list.
; Vykreslení šestnácti různých kombinací pixelů.
; Přepnutí do GTIA režimu 9.
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE

; dva bloky RAM využité jako obrazová paměť
screen1 = $7000
screen2 = $8000



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
; vyplnění obrazovky
; ---------------------------------------------------------------------
.macro  fill_screen screen
        .local next_line        ; definice lokálního symbolu
        .local draw_on_line     ; definice lokálního symbolu
        screen_addr = 128

        lda #<screen1           ; uložit adresu začátku obrazovky na nultou stránku
        sta screen_addr
        lda #>screen1
        sta screen_addr+1

        ldx #96                 ; počitadlo řádků
next_line:
        lda #0                  ; zapisovaná hodnota + počitadlo smyčky
        tay                     ; offset do obrazové paměti
        clc                     ; nechceme přičítat přenos
        ; ---------------------------------------------------------------------
        ; vykreslení pixelů na jednom řádku
        ; ---------------------------------------------------------------------
draw_on_line:
        sta (screen_addr), y    ; zápis na první řádek
        iny                     ; další zápis bude proveden o jeden bajt dále
        adc #1                  ; zvýšení hodnoty v akumulátoru
        cmp #40                 ; konec smyčky?
        bne draw_on_line        ; dokud není nula, pokračovat

        lda screen_addr         ; 16bitové zvýšení adresy
        clc
        adc #40
        sta screen_addr
        lda screen_addr+1
        adc #0
        sta screen_addr+1

        dex                     ; snížení počitadla
        bne next_line           ; jsme na posledním řádku? ne->skok
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
        fill_screen screen1     ; vyplnění obrazovky
        jsr get_key             ; čekání na stisk klávesy

        jsr gtia_mode_9         ; nastavení GTIA režimu číslo 9

        game_loop               ; hlavní herní smyčka
.endproc



; ---------------------------------------------------------------------
; nastavení GTIA režimu číslo 9
; ---------------------------------------------------------------------
.proc gtia_mode_9
        lda GPRIOR              ; modifikace stínového registru GPRIOR
        ora  #$40               ; výběr GTIA režimu GR.9
        sta GPRIOR
        rts                     ; vyber adresy ze zasobniku + skok
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
