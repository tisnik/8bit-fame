.CODE

.proc main
loop:   jmp loop
end:
.endproc


.segment "EXEHDR"
.word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
.word   main                    ; zacatek kodoveho segmentu
.word   main::end - 1           ; konec kodoveho segmentu


.segment "AUTOSTRT"             ; segment s pocatecni adresou
.word   $02E0                   ; naplni se pouze adresy RUNAD a RUNAD+1
.word   $02E1
.word   main                    ; adresa vstupniho bodu do programu

; finito
