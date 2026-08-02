.include "atari.inc"

.CODE

IOCB4 = $40              ; offset odvozený od čísla IOCB kanálu (nutno násobit šestnácti)



; ---------------------------------------------------------------------
; hlavní program
; ---------------------------------------------------------------------
.proc main
        jsr CLOSE_CHANNEL_4
        jsr OPEN_CHANNEL_4_AS_H
        jsr WRITE_BYTE_CHANNEL_4
        jsr CLOSE_CHANNEL_4
loop:
        jmp loop                ; program vlastně nice nedělá - jen cyklí!
.endproc



; ---------------------------------------------------------------------
; uzavření kanálu číslo 4
; ---------------------------------------------------------------------
.proc CLOSE_CHANNEL_4
        rts                     ; návrat ze subrutiny
.endproc



; ---------------------------------------------------------------------
; otevření kanálu číslo 4 v režimu zápisu na zařízení H:test.txt
; ---------------------------------------------------------------------
.proc OPEN_CHANNEL_4_AS_H
        rts                     ; návrat ze subrutiny
.endproc



; ---------------------------------------------------------------------
; zápis jednoho znaku do kanálu číslo 4
; ---------------------------------------------------------------------
.proc WRITE_BYTE_CHANNEL_4
        rts                     ; návrat ze subrutiny
.endproc


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
