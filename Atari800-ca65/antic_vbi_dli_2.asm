; ---------------------------------------------------------------------
; Ovládání PMG joystickem v horizontálním směru.
; Změna pozice PMG realizovaná ve VBI.
; Změna barvy herního pole realizovaná v DLI.
; Odstranění nadbytečné instrukce RTS ve VBI.
;
; Tento zdrojový kód byl použit v článku:
;
; VBI (Vertical Blank Interrupt) na osmibitových mikropočítačích Atari
; https://www.root.cz/clanky/vbi-vertical-blank-interrupt-na-osmibitovych-mikropocitacich-atari/
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE

PLAYER_0_OFFSET = 512
PLAYER_1_OFFSET = PLAYER_0_OFFSET + 128
PLAYER_2_OFFSET = PLAYER_1_OFFSET + 128
PLAYER_3_OFFSET = PLAYER_2_OFFSET + 128


; ---------------------------------------------------------------------
; vstupní bod do programu
; ---------------------------------------------------------------------
.proc main
        lda #<dlist             ; nižší byte adresy display listu
        sta SDLSTL
        lda #>dlist             ; vyšší byte adresy display listu
        sta SDLSTH

        ldy #0                  ; počitadlo zápisů
clear:
        tya                     ; kód vypisovaného znaku
        sta screen, y           ; tisk znaku na zvolené místo na obrazovce
        sta screen+40*8, y
        sta screen+40*16, y
        iny                     ; zvětšit hodnotu počitadla a offsetu
        cpy #$80
        bne clear               ; skok

        ; vektor DLI
        lda #<dli               ; nastavení DLI
        sta VDSLST
        lda #>dli
        sta VDSLST+1

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

        lda #1                   ; priorita hráčů a pozadí
        sta GPRIOR              ; uložit do řídicího registru GPRIOR na čipu GTIA

        lda #152                ; paměťová stránka číslo 152
        sta PMBASE

        addr = 152*256
        ldx #8                  ; začneme na hodnotě o 1 vyšší
next_line:
        lda sprite-1, x         ; načíst
        sta addr+PLAYER_0_OFFSET+100, x  ; uložit byte - první hráč
        sta addr+PLAYER_1_OFFSET+100, x  ; uložit byte - druhý hráč
        sta addr+PLAYER_2_OFFSET+100, x  ; uložit byte - třetí hráč
        sta addr+PLAYER_3_OFFSET+100, x  ; uložit byte - čtvrtý hráč
        dex                     ; snížit offset + nastavit příznaky
        bne next_line           ; další byte spritu

        lda #46                 ; povolení PMG DMA
        sta SDMCTL

        ; nastavit vektor pro odloženou VBI
        lda #7                  ; změna vektoru pro odložené VBI
        ldx #>horizontal_movement
        ldy #<horizontal_movement
        jsr SETVBV              ; zavolat službu systému pro nastavení vektoru

        ; povolení DLI
        NMIEN_DLI=$80           ; maska povolení DLI
        NMIEN_VBI=$40           ; maska povolení VBI
        lda #NMIEN_DLI | NMIEN_VBI ; povolení DLI
        sta NMIEN

loop:
        jmp loop                ; program vlastně nice nedělá - jen cyklí!
.endproc


; ---------------------------------------------------------------------
; subrutina pro obsluhu VBI
; ---------------------------------------------------------------------
.proc   horizontal_movement
        ldx x_pos               ; původní pozice prvního hráče

        lda STICK0              ; čtení joysticku
        cmp #11                 ; je nakloněn doleva?
        bne not_left
        dex                     ; posun hráče doleva
not_left:
        cmp #7                  ; je nakloněn doprava?
        bne not_right
        inx                     ; posun hráče doprava
not_right:
        stx HPOSP0              ; změna pozice prvního hráče
        stx x_pos               ; zapamatovat si pozici prvního hráče
        jmp XITVBV              ; zpracovat zbytek odloženého VBLANKu
.endproc


; ---------------------------------------------------------------------
; obsluha DLI
; ---------------------------------------------------------------------
dli:
        pha                     ; uschovat akumulátor
        lda color               ; barva pozadí
        sta COLPF2              ; přímo nastavit zápisem do HW registru
        eor #%10000000          ; negovat nejvyšší bit
        sta color
        pla                     ; obnovit akumulátor
        rti                     ; návrat z DLI


dlist:
.byte DL_BLK8, DL_BLK8, DL_BLK8 ; 3x8=24 prázdných obrazových řádků
.byte DL_LMS+DL_CHR40x8x1       ; určení počáteční adresy obrazové paměti + jeden řádek režimu 2 (GR.0)
.byte <screen, >screen          ; počáteční adresa obrazové paměti 
.res 6, DL_CHR40x8x1            ; opakovat řádky textového režimu 2 (GR.0)
.byte DL_DLI+DL_CHR40x8x1       ; GR.0 ovšem navíc s povolením DLI
.res 7, DL_CHR40x8x1            ; opakovat řádky textového režimu 2 (GR.0)
.byte DL_DLI+DL_CHR40x8x1       ; GR.0 ovšem navíc s povolením DLI
.res 8, DL_CHR40x8x1            ; opakovat řádky textového režimu 2 (GR.0)
.byte DL_JVB, <dlist, >dlist    ; skok na začátek display listu


color:
.byte $c4                       ; původní barva


; data
sprite:   .byte 24, 60, 126, 219, 255, 36, 90, 165

; horizontální pozice hráče
x_pos:    .byte 80

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
