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

; adresy PMG
PLAYER_0_OFFSET = 512
PLAYER_1_OFFSET = PLAYER_0_OFFSET + 128
PLAYER_2_OFFSET = PLAYER_1_OFFSET + 128
PLAYER_3_OFFSET = PLAYER_2_OFFSET + 128


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
; makro pro nastavení DLI
; ---------------------------------------------------------------------
.macro  set_dli_handler handler
        ; vektor DLI
        lda #<handler           ; nastavení DLI
        sta VDSLST
        lda #>handler
        sta VDSLST+1
.endmacro


; ---------------------------------------------------------------------
; makro pro nastavení VBI
; ---------------------------------------------------------------------
.macro set_vbi_handler handler
        ; nastavit vektor pro odloženou VBI
        lda #>handler
        sta VVBLKD+1
        lda #<handler
        sta VVBLKD
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
; set PMG
; ---------------------------------------------------------------------
.macro  set_pmg
        .local next_line        ; definice lokálního symbolu

        lda #80                 ; horizontální pozice prvního hráče
        sta HPOSP0              ; uložit do řídicího registru HPOSP0 na čipu GTIA

        lda #100                ; horizontální pozice druhého hráče
        sta HPOSP1              ; uložit do řídicího registru HPOSP1 na čipu GTIA

        lda #120                ; horizontální pozice třetího hráče
        sta HPOSP2              ; uložit do řídicího registru HPOSP2 na čipu GTIA

        lda #140                ; horizontální pozice čtvrtého hráče
        sta HPOSP3              ; uložit do řídicího registru HPOSP3 na čipu GTIA

        lda #HUE_BLUE<<4 + 12 ; barva druhého hráče (odstín+intenzita)
        sta PCOLR0              ; uložit do řídicího registru PCOLR0 na čipu GTIA

        lda #HUE_GREEN<<4 + 12  ; barva prvního hráče (odstín+intenzita)
        sta PCOLR1              ; uložit do řídicího registru PCOLR1 na čipu GTIA

        lda #HUE_MAGENTA<<4 + 12 ; barva třetího hráče (odstín+intenzita)
        sta PCOLR2              ; uložit do řídicího registru PCOLR2 na čipu GTIA

        lda #HUE_CYAN<<4 + 12   ; barva čtvrtého hráče (odstín+intenzita)
        sta PCOLR3              ; uložit do řídicího registru PCOLR3 na čipu GTIA

        lda #$ff                ; bitová maska všech hráčů
        sta GRAFP0              ; uložit do řídicího registru GRAFP0 na čipu GTIA
        sta GRAFP1              ; uložit do řídicího registru GRAFP1 na čipu GTIA
        sta GRAFP2              ; uložit do řídicího registru GRAFP2 na čipu GTIA
        sta GRAFP3              ; uložit do řídicího registru GRAFP3 na čipu GTIA

        lda #3                  ; bitové pole: povolení hráčů i střel
        sta GRACTL              ; uložit do řídicího registru GRACTL na čipu GTIA

        lda #0                  ; priorita hráčů a pozadí
        sta GPRIOR              ; uložit do řídicího registru GPRIOR na čipu GTIA

        lda #152                ; paměťová stránka číslo 152
        sta PMBASE

        addr = 152*256
        ldx #8                  ; začneme na hodnotě o 1 vyšší
next_line:
        lda sprite-1, x         ; načíst
        sta addr+PLAYER_0_OFFSET+20, x  ; uložit byte - první hráč
        sta addr+PLAYER_1_OFFSET+30, x  ; uložit byte - druhý hráč
        sta addr+PLAYER_2_OFFSET+40, x  ; uložit byte - třetí hráč
        sta addr+PLAYER_3_OFFSET+50, x  ; uložit byte - čtvrtý hráč
        dex                     ; snížit offset + nastavit příznaky
        bne next_line           ; další byte spritu

        lda #46                 ; povolení PMG DMA
        sta SDMCTL
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
        set_pmg                 ; nastavení PMG

        set_dli_handler dli     ; nastavení obsluhy DLI
        set_vbi_handler horizontal_movement
        fill_screen screen1     ; vyplnění obrazovky
        jsr get_key             ; čekání na stisk klávesy

        jsr enable_dli          ; povolení DLI (a VBI)
        jsr get_key             ; čekání na stisk klávesy

        jsr gtia_mode_9         ; nastavení GTIA režimu číslo 9

        game_loop               ; hlavní herní smyčka
.endproc



; ---------------------------------------------------------------------
; povolení DLI (a VBI)
; ---------------------------------------------------------------------
.proc enable_dli
        ; povolení DLI
        NMIEN_DLI=$80           ; maska povolení DLI
        NMIEN_VBI=$40           ; maska povolení VBI
        lda #NMIEN_DLI | NMIEN_VBI ; povolení DLI
        sta NMIEN
        rts
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


; ---------------------------------------------------------------------
; obsluha DLI
; ---------------------------------------------------------------------
dli:
        pha                     ; uschovat akumulátor
        lda color               ; barva pozadí
        clc
        adc #16
        sta COLBK               ; přímo nastavit zápisem do HW registru
        sta color
        pla                     ; obnovit akumulátor
        rti                     ; návrat z DLI


; ---------------------------------------------------------------------
; subrutina pro obsluhu VBI
; ---------------------------------------------------------------------
.proc   horizontal_movement
        ldx x_pos_0             ; původní pozice prvního hráče
        dex                     ; posun hráče doleva
        stx HPOSP0              ; změna pozice prvního hráče
        stx x_pos_0             ; zapamatovat si pozici prvního hráče

        ldx x_pos_1             ; původní pozice prvního hráče
        inx                     ; posun hráče doprava
        stx HPOSP1              ; změna pozice prvního hráče
        stx x_pos_1             ; zapamatovat si pozici prvního hráče

        ldx x_pos_2             ; původní pozice prvního hráče
        dex                     ; posun hráče doleva
        dex                     ; posun hráče doleva
        stx HPOSP2              ; změna pozice prvního hráče
        stx x_pos_2             ; zapamatovat si pozici prvního hráče

        ldx x_pos_3             ; původní pozice prvního hráče
        inx                     ; posun hráče doprava
        inx                     ; posun hráče doprava
        stx HPOSP3              ; změna pozice prvního hráče
        stx x_pos_3             ; zapamatovat si pozici prvního hráče

        jmp XITVBV              ; zpracovat zbytek odloženého VBLANKu
        rts
.endproc


dlist:
.byte DL_BLK8, DL_BLK8, DL_BLK8 ; 3x8=24 prázdných obrazových řádků
.byte DL_LMS+DL_MAP320x1x1      ; určení počáteční adresy obrazové paměti + jeden řádek režimu F (GR.8)
.byte <screen1, >screen1        ; počáteční adresa obrazové paměti (první blok)
.res 5,  DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_MAP320x1x1+DL_DLI      ; povolení DLI
.res 5,  DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_MAP320x1x1+DL_DLI      ; povolení DLI
.res 5,  DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_MAP320x1x1+DL_DLI      ; povolení DLI
.res 5,  DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_MAP320x1x1+DL_DLI      ; povolení DLI
.res 5,  DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_MAP320x1x1+DL_DLI      ; povolení DLI
.res 5,  DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_MAP320x1x1+DL_DLI      ; povolení DLI
.res 5,  DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_MAP320x1x1+DL_DLI      ; povolení DLI
.res 5,  DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_MAP320x1x1+DL_DLI      ; povolení DLI
.res 5,  DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_MAP320x1x1+DL_DLI      ; povolení DLI
.res 5,  DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_MAP320x1x1+DL_DLI      ; povolení DLI
.res 5,  DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_MAP320x1x1+DL_DLI      ; povolení DLI
.res 5,  DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_MAP320x1x1+DL_DLI      ; povolení DLI
.res 5,  DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_MAP320x1x1+DL_DLI      ; povolení DLI
.res 5,  DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_MAP320x1x1+DL_DLI      ; povolení DLI
.res 5,  DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_MAP320x1x1+DL_DLI      ; povolení DLI
.res 5,  DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_MAP320x1x1+DL_DLI      ; povolení DLI
.byte DL_LMS+DL_MAP320x1x1      ; určení počáteční adresy obrazové paměti + jeden řádek režimu F (GR.8)
.byte <screen2, >screen2        ; počáteční adresa obrazové paměti (druhý blok)
.res 95, DL_MAP320x1x1          ; opakovat řádky grafického režimu F (GR.8)
.byte DL_JVB, <dlist, >dlist    ; skok na začátek display listu

; barva v GTIA režimu 9
color: .byte 1

; data spritů
sprite:  .byte 24, 60, 126, 219, 255, 36, 90, 165
x_pos_0: .byte 80
x_pos_1: .byte 100
x_pos_2: .byte 120
x_pos_3: .byte 140

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
