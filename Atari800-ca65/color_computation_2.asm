.include "atari.inc"

HUE_COLOR_GRAY        = $0
HUE_COLOR_GOLD        = $1
HUE_COLOR_ORANGE_1    = $2
HUE_COLOR_PINK        = $3
HUE_COLOR_MAGENTA     = $4
HUE_COLOR_BLUE        = $5
HUE_COLOR_INDIGO      = $6
HUE_COLOR_SKY_BLUE    = $7
HUE_COLOR_ROYAL_BLUE  = $8
HUE_COLOR_LIGHT_BLUE  = $9
HUE_COLOR_TURQOISE    = $A
HUE_COLOR_AQUAMARIN   = $B
HUE_COLOR_SEA_GREEN   = $C
HUE_COLOR_LIGHT_GREEN = $D
HUE_COLOR_OLIVE       = $E
HUE_COLOR_ORANGE_2    = $F

.CODE


.proc main
        lda #HUE_COLOR_MAGENTA  ; kod odstinu barvy
        clc                     ; vymazat priznak prenosu
        asl A                   ; provest 4x aritmeticky posun doprava
        asl A
        asl A
        asl A
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
