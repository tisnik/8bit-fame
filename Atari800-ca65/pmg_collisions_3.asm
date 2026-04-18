; ---------------------------------------------------------------------
; Ovládání PMG joystickem. Detekce kolize prvního hráče s dalšími hráči.
; Detekce kolize první střely s hráči.
;
; Tento zdrojový kód byl použit v článku:
;
; Dokončení popisu čipu GTIA: horizontální posun spritů a detekce kolizí
; https://www.root.cz/clanky/dokonceni-popisu-cipu-gtia-horizontalni-posun-spritu-a-detekce-kolizi/
; 
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE

PLAYER_0_OFFSET = 512
PLAYER_1_OFFSET = PLAYER_0_OFFSET + 128
PLAYER_2_OFFSET = PLAYER_1_OFFSET + 128
PLAYER_3_OFFSET = PLAYER_2_OFFSET + 128
MISSILES_OFFSET = 384


.proc main
        lda #80                 ; horizontální pozice prvního hráče
        sta HPOSP0              ; uložit do řídicího registru HPOSP0 na čipu GTIA

        lda #90                 ; horizontální pozice druhého hráče
        sta HPOSP1              ; uložit do řídicího registru HPOSP1 na čipu GTIA

        lda #100                ; horizontální pozice třetího hráče
        sta HPOSP2              ; uložit do řídicího registru HPOSP2 na čipu GTIA

        lda #110                ; horizontální pozice čtvrtého hráče
        sta HPOSP3              ; uložit do řídicího registru HPOSP3 na čipu GTIA

        lda #140                ; horizontální pozice první střely
        sta HPOSM0              ; uložit do řídicího registru HPOSP0 na čipu GTIA

        lda #144                ; horizontální pozice druhé střely
        sta HPOSM1              ; uložit do řídicího registru HPOSP1 na čipu GTIA

        lda #148                ; horizontální pozice třetí střely
        sta HPOSM2              ; uložit do řídicího registru HPOSP2 na čipu GTIA

        lda #152                ; horizontální pozice čtvrté střely
        sta HPOSM3              ; uložit do řídicího registru HPOSP3 na čipu GTIA

        lda #HUE_GREEN<<4 + 12  ; barva prvního hráče (odstín+intenzita)
        sta PCOLR0              ; uložit do řídicího registru PCOLR0 na čipu GTIA

        lda #HUE_YELLOW<<4 + 12 ; barva druhého hráče (odstín+intenzita)
        sta PCOLR1              ; uložit do řídicího registru PCOLR1 na čipu GTIA

        lda #HUE_MAGENTA<<4 + 12 ; barva třetího hráče (odstín+intenzita)
        sta PCOLR2              ; uložit do řídicího registru PCOLR2 na čipu GTIA

        lda #HUE_CYAN<<4 + 12   ; barva čtvrtého hráče (odstín+intenzita)
        sta PCOLR3              ; uložit do řídicího registru PCOLR3 na čipu GTIA

        lda #HUE_YELLOWRED<<4 + 8   ; barva pátého hráče (odstín+intenzita)
        sta COLOR3              ; uložit do řídicího registru COLPF3 na čipu GTIA

        lda #3                  ; bitové pole: povolení hráčů i střel
        sta GRACTL              ; uložit do řídicího registru GRACTL na čipu GTIA

        lda #0                  ; priorita hráčů a pozadí
        sta GPRIOR              ; uložit do řídicího registru GPRIOR na čipu GTIA

        lda #152                ; paměťová stránka číslo 152
        sta PMBASE

        addr = 152*256
        ldx #10                 ; začneme na hodnotě o 1 vyšší
next_line:
        lda sprite-1, x         ; načíst
        sta addr+PLAYER_0_OFFSET+50, x  ; uložit byte - první hráč
        sta addr+PLAYER_1_OFFSET+50, x  ; uložit byte - druhý hráč
        sta addr+PLAYER_2_OFFSET+50, x  ; uložit byte - třetí hráč
        sta addr+PLAYER_3_OFFSET+50, x  ; uložit byte - čtvrtý hráč
        dex                     ; snížit offset + nastavit příznaky
        bne next_line           ; další byte spritu

        lda #$55                ; bitmapy střel
        sta addr+MISSILES_OFFSET+55  ; uložit byte - střely

        lda #46                 ; povolení PMG DMA
        sta SDMCTL

; zde začíná "herní kernel"
        ldx #80                 ; výchozí pozice prvního hráče
        ldy #60                 ; X i Y
loop:
        jsr _wait_vsync         ; čekání na vykreslení snímku
        jsr _wait_vsync
        jsr _wait_vsync
        jsr _wait_vsync

        lda STICK0              ; čtení joysticku
        cmp #11                 ; je nakloněn doleva?
        bne not_left
        dex                     ; posun hráče doleva
not_left:
        cmp #7                  ; je nakloněn doprava?
        bne not_right
        inx                     ; posun hráče doprava
not_right:
        cmp #14                 ; je nakloněn nahoru?
        bne not_up
        dey                     ; změna Y-ové souřadnice hráče
        jsr draw_at_y           ; překreslení spritu
not_up:
        cmp #13                 ; je nakloněn dolů?
        bne not_down
        iny                     ; změna Y-ové souřadnice hráče
        jsr draw_at_y           ; překreslení spritu
not_down:
        stx HPOSP0              ; změna pozice prvního hráče
        lda P0PL                ; načíst informace o kolizích prvního hráče
        clc
        adc M0PL
        asl                     ; posun na pozice informace o odstínu
        asl
        asl
        asl
        clc
        adc #12                 ; přidat světlost barvy

        sta PCOLR0              ; změnit barvu prvního hráče
        sta HITCLR              ; vymazat informace o kolizích

        jmp loop

.endproc


.proc   _wait_vsync
        txa                     ; uložení obsahu X do akumulátoru
        ldx     RTCLOK+2        ; čekání na konec snímku
@wt:    cpx     RTCLOK+2
        beq     @wt
        tax                     ; obnovení obsahu X z akumulátoru
        rts
.endproc


.proc  draw_at_y
        addr = 152*256          ; adresa první stránky se sprity
        txa
        pha                     ; uložit X na zásobník
        tya
        pha                     ; uložit Y na zásobník

        ldx #10                 ; začneme na hodnotě o 1 vyšší
next_line:
        lda sprite-1, x         ; načíst
        sta addr+PLAYER_0_OFFSET, y  ; uložit byte - první hráč
        dey
        dex                     ; snížit offset + nastavit příznaky
        bne next_line           ; další byte spritu

        pla
        tay                     ; obnovit Y ze zásobníku
        pla
        tax                     ; obnovit X ze zásobníku
        rts                     ; návrat z podprogramu
.endproc


; data
sprite:   .byte 0, 24, 60, 126, 219, 255, 36, 90, 165, 0

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
