ca65 V2.18 - Fedora 2.19-12.fc42
Main file   : background_color_1.asm
Current file: background_color_1.asm

000000r 1               .CODE
000000r 1               
000000r 1               .proc main
000000r 1  A9 00                lda #0                  ; kod barvy
000002r 1  8D C6 02             sta 710                 ; ulozit do registru COLOR2
000005r 1  4C rr rr     loop:   jmp loop
000008r 1               end:
000008r 1               .endproc
000008r 1               
000008r 1               
000008r 1               .segment "EXEHDR"
000000r 1  FF FF        .word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
000002r 1  rr rr        .word   main                    ; zacatek kodoveho segmentu
000004r 1  rr rr        .word   main::end - 1           ; konec kodoveho segmentu
000006r 1               
000006r 1               
000006r 1               .segment "AUTOSTRT"             ; segment s pocatecni adresou
000000r 1  E0 02        .word   $02E0                   ; naplni se pouze adresy RUNAD a RUNAD+1
000002r 1  E1 02        .word   $02E1
000004r 1  rr rr        .word   main                    ; adresa vstupniho bodu do programu
000006r 1               
000006r 1               ; finito
000006r 1               
