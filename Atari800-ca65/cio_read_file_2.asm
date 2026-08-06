.include "atari.inc"

.CODE

IOCB0 = $00              ; offset odvozený od čísla IOCB kanálu (nutno násobit šestnácti)
IOCB4 = $40              ; offset odvozený od čísla IOCB kanálu (nutno násobit šestnácti)



; ---------------------------------------------------------------------
; hlavní program
; ---------------------------------------------------------------------
.proc main
        jsr CLOSE_CHANNEL_4
        jsr OPEN_CHANNEL_4_AS_H
        jsr READ_MESSAGE_FROM_CHANNEL_4
	jsr WRITE_MESSAGE_INTO_CHANNEL_0
        jsr CLOSE_CHANNEL_4
loop:
        jmp loop                ; program vlastně nice nedělá - jen cyklí!
.endproc



; ---------------------------------------------------------------------
; uzavření kanálu číslo 4
; ---------------------------------------------------------------------
.proc CLOSE_CHANNEL_4
        ldx #IOCB4              ; offset odvozený od čísla IOCB kanálu
        lda #CLOSE              ; prováděná operace
        sta ICCOM, x            ; zápis prováděné operace do bloku IOCB
        jsr CIOV                ; zavolání rutiny pro CIO
        rts                     ; návrat ze subrutiny
.endproc



; ---------------------------------------------------------------------
; otevření kanálu číslo 4 v režimu zápisu na zařízení H:test.txt
; ---------------------------------------------------------------------
.proc OPEN_CHANNEL_4_AS_H
        ldx #IOCB4              ; offset odvozený od čísla IOCB kanálu
        lda #OPEN               ; prováděná operace
        sta ICCOM, x            ; zápis prováděné operace do bloku IOCB

        ; specifikace jména zařízení + jména souboru (16bitový ukazatel)
        lda #<device_name
        sta ICBAL, x
        lda #>device_name
        sta ICBAH, x

        lda #OPNIN              ; režim otevření: čtení (odpovídá druhému parametru příkazu OPEN v BASICu)
        sta ICAX1, x
        lda #0                  ; odpovídá třetímu parametru příkazu OPEN v BASICu
        sta ICAX2, x

        jsr CIOV                ; zavolání rutiny pro CIO

        rts                     ; návrat ze subrutiny
.endproc



; ---------------------------------------------------------------------
; čtení zprávy z kanálu číslo 4
; ---------------------------------------------------------------------
.proc READ_MESSAGE_FROM_CHANNEL_4
        ldx #IOCB4              ; offset odvozený od čísla IOCB kanálu
        lda #GETCHR             ; prováděná operace
        sta ICCOM, x            ; zápis prováděné operace do bloku IOCB

        ; adresa bloku
        lda #<buffer
        sta ICBAL, x
        lda #>buffer
        sta ICBAH, x

        ; nastavení počtu čtených bajtů
        lda #(end_of_buffer-buffer)
        sta ICBLL, x
        lda #0
        sta ICBLH, x

        jsr CIOV                ; zavolání rutiny pro CIO
        rts                     ; návrat ze subrutiny
.endproc



; ---------------------------------------------------------------------
; zápis zprávy na obrazovku
; ---------------------------------------------------------------------
.proc WRITE_MESSAGE_INTO_CHANNEL_0
        ldx #IOCB0              ; offset odvozený od čísla IOCB kanálu
        lda #PUTCHR             ; prováděná operace
        sta ICCOM, x            ; zápis prováděné operace do bloku IOCB

        ; adresa bloku
        lda #<buffer
        sta ICBAL, x
        lda #>buffer
        sta ICBAH, x

        ; nastavení počtu čtených bajtů
        lda #(end_of_buffer-buffer)
        sta ICBLL, x
        lda #0
        sta ICBLH, x

        jsr CIOV                ; zavolání rutiny pro CIO
        rts                     ; návrat ze subrutiny
.endproc



; jméno zařízení (+ jméno souboru) ukončené nulou
device_name: .byte "H:HELLO.TXT", 0

; buffer
buffer: .res 52
end_of_buffer:

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
