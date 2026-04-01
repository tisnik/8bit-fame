; ---------------------------------------------------------------------
; Nastavení barvy pozadí ve výchozím textovém režimu GR.0
;
; Tento zdrojový kód byl použit v článku:
;
; Kouzlo minimalismu potřetí: vývoj her a dem pro osmibitová Atari
; https://www.root.cz/clanky/kouzlo-minimalismu-potreti-vyvoj-her-a-dem-pro-osmibitova-atari/
; ---------------------------------------------------------------------

.CODE


.proc main
        lda #0                  ; kod barvy
        sta 710                 ; ulozit do registru COLOR2
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
