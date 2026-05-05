; ---------------------------------------------------------------------
; Zobrazení osmi spritů namísto čtyř spritů s využitím DLI.
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE

PLAYER_0_OFFSET = 512
PLAYER_1_OFFSET = PLAYER_0_OFFSET + 128
PLAYER_2_OFFSET = PLAYER_1_OFFSET + 128
PLAYER_3_OFFSET = PLAYER_2_OFFSET + 128


.proc main
        lda #<dlist             ; nižší byte adresy display listu
        sta SDLSTL
        lda #>dlist             ; vyšší byte adresy display listu
        sta SDLSTH

        lda #80                 ; horizontální pozice prvního hráče
        sta HPOSP0              ; uložit do řídicího registru HPOSP0 na čipu GTIA

        lda #100                ; horizontální pozice druhého hráče
        sta HPOSP1              ; uložit do řídicího registru HPOSP1 na čipu GTIA

        lda #120                ; horizontální pozice třetího hráče
        sta HPOSP2              ; uložit do řídicího registru HPOSP2 na čipu GTIA

        lda #140                ; horizontální pozice čtvrtého hráče
        sta HPOSP3              ; uložit do řídicího registru HPOSP3 na čipu GTIA

        lda #HUE_GREEN<<4 + 12  ; barva prvního hráče (odstín+intenzita)
        sta PCOLR0              ; uložit do řídicího registru PCOLR0 na čipu GTIA

        lda #HUE_YELLOW<<4 + 12 ; barva druhého hráče (odstín+intenzita)
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
        sta addr+PLAYER_0_OFFSET+30, x  ; uložit byte - první hráč
        sta addr+PLAYER_1_OFFSET+30, x  ; uložit byte - druhý hráč
        sta addr+PLAYER_2_OFFSET+30, x  ; uložit byte - třetí hráč
        sta addr+PLAYER_3_OFFSET+30, x  ; uložit byte - čtvrtý hráč
        sta addr+PLAYER_0_OFFSET+80, x  ; uložit byte - první hráč
        sta addr+PLAYER_1_OFFSET+80, x  ; uložit byte - druhý hráč
        sta addr+PLAYER_2_OFFSET+80, x  ; uložit byte - třetí hráč
        sta addr+PLAYER_3_OFFSET+80, x  ; uložit byte - čtvrtý hráč
        dex                     ; snížit offset + nastavit příznaky
        bne next_line           ; další byte spritu

        lda #46                 ; povolení PMG DMA
        sta SDMCTL

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


; ---------------------------------------------------------------------
; obsluha DLI
; ---------------------------------------------------------------------
dli:
        pha                     ; uschovat akumulátor

        lda #$2f                ; dočasné barvy hráčů
        sta COLPM0

        lda #$4f                ; dočasné barvy hráčů
        sta COLPM1

        lda #$6f                ; dočasné barvy hráčů
        sta COLPM2

        lda #$2f                ; dočasné barvy hráčů
        sta COLPM3

        lda offset              ; horizontální pozice prvního hráče
        sta HPOSP0              ; uložit do řídicího registru HPOSP0 na čipu GTIA
        cmp #80                 ; prohazovat souřadnice 80 a 160
        bne next
        lda #160
        sta offset

        pla                     ; obnovit akumulátor
        rti                     ; návrat z DLI
next:
        lda #80
        sta offset

        pla                     ; obnovit akumulátor
        rti                     ; návrat z DLI


.endproc

dlist:
.byte DL_BLK8, DL_BLK8, DL_BLK8 ; 3x8=24 prázdných obrazových řádků
.byte DL_LMS+DL_CHR40x8x1       ; určení počáteční adresy obrazové paměti + jeden řádek režimu 2 (GR.0)
.byte <screen, >screen          ; počáteční adresa obrazové paměti 
.res 10, DL_CHR40x8x1           ; opakovat řádky textového režimu 2 (GR.0)
.byte DL_DLI+DL_CHR40x8x1       ; GR.0 ovšem navíc s povolením DLI
.res 11, DL_CHR40x8x1           ; opakovat řádky textového režimu 2 (GR.0)
.byte DL_DLI+DL_CHR40x8x1       ; GR.0 ovšem navíc s povolením DLI
.byte DL_JVB, <dlist, >dlist    ; skok na začátek display listu

offset:   .byte 80

; data
sprite:   .byte 24, 60, 126, 219, 255, 36, 90, 165

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
