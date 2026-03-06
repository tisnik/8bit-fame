.include "atari.inc"

HUE_COLOR_GRAY        = 16 * $0
HUE_COLOR_GOLD        = 16 * $1
HUE_COLOR_ORANGE_1    = 16 * $2
HUE_COLOR_PINK        = 16 * $3
HUE_COLOR_MAGENTA     = 16 * $4
HUE_COLOR_BLUE        = 16 * $5
HUE_COLOR_INDIGO      = 16 * $6
HUE_COLOR_SKY_BLUE    = 16 * $7
HUE_COLOR_ROYAL_BLUE  = 16 * $8
HUE_COLOR_LIGHT_BLUE  = 16 * $9
HUE_COLOR_TURQOISE    = 16 * $A
HUE_COLOR_AQUAMARIN   = 16 * $B
HUE_COLOR_SEA_GREEN   = 16 * $C
HUE_COLOR_LIGHT_GREEN = 16 * $D
HUE_COLOR_OLIVE       = 16 * $E
HUE_COLOR_ORANGE_2    = 16 * $F

.CODE

.proc main
        lda #HUE_COLOR_MAGENTA  ; kod odstinu barvy
        clc                     ; vymazat priznak prenosu
        adc #6                  ; svetlost v rozsahu 0..14 s krokem 2
        sta COLOR2              ; ulozit do registru COLOR2
loop:   jmp loop
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
