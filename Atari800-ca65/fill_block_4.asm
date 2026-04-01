; ---------------------------------------------------------------------
; Vyplnění bloku většího než 256 bajtů konstantou.
;
; Tento zdrojový kód byl použit v článku:
;
; Programování pro osmibitová Atari: blokové výplně a přesuny dat, grafický subsystém
; https://www.root.cz/clanky/programovani-pro-osmibitova-atari-blokove-vyplne-a-presuny-dat-graficky-subsystem/
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE

to = $80                        ; dva bajty z nulté stránky

.proc main
        lda 88                  ; načíst část adresy počátku video RAM
        sta to                  ; uložit do "proměnné"
        lda 89                  ; načíst část adresy počátku video RAM
        sta to+1                ; uložit do "proměnné"

        lda #33                 ; kod znaku, ktery se bude tisknout

        ldy #0                  ; offset pro zápis
        ldx sizeh               ; vyšší bajt velikosti (počet bloků)
        beq fill2               ; je nulový? -> přeneseme jen zbylé bajty
fill1:  sta (to), y             ; zápis do bloku
        iny                     ; zvýšit offset
        bne  fill1              ; počítáme až do 256
        inc to+1                ; zvýšit adresu (!!!)
        dex                     ; zmenšit počitadlo bloků
        bne fill1               ; pokračovat dalším blokem
fill2:  ldx sizel               ; nižší bajt velikosti (počet zbývajících bajtů)
        beq fill4               ; je nulový? -> vše hotovo!
fill3:  sta (to), y             ; přenést zbylé bajty (méně než 256)
        iny                     ; zvýšit offset
        dex                     ; zmenšit počitadlo smyčky
        bne fill3               ; opakujeme dokud se X nevynuluje
fill4:

loop:   jmp loop

; data
sizeh:    .byte  >800           ; vyšší bajt velikosti
sizel:    .byte  <800           ; nižší bajt velikosti

end:
.endproc


.segment "EXEHDR"
.word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
.word   main                    ; zacatek kodoveho segmentu
.word   main::end - 1           ; konec kodoveho segmentu


.segment "AUTOSTRT"             ; segment s pocatecni adresou
.word   RUNAD                   ; naplni se pouze adresy RUNAD a RUNAD+1
.word   RUNAD+1
.word   main                    ; adresa vstupniho bodu do programu

; finito
