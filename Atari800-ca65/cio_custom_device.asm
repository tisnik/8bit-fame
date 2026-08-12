.include "atari.inc"

.CODE

IOCB4 = $40              ; offset odvozený od čísla IOCB kanálu (nutno násobit šestnácti)



; ---------------------------------------------------------------------
; hlavní program
; ---------------------------------------------------------------------
.proc main
        jsr REGISTER_NULL_DEVICE
        jsr CLOSE_CHANNEL_4
        jsr OPEN_CHANNEL_4_AS_N
        jsr WRITE_BYTE_CHANNEL_4
        jsr CHECK_ERROR
        jsr CLOSE_CHANNEL_4
loop:
        jmp loop                ; program vlastně nice nedělá - jen cyklí!
.endproc



; ---------------------------------------------------------------------
; registrace nového zařízení
; ---------------------------------------------------------------------
.proc REGISTER_NULL_DEVICE

insert:
        ldx #0
next_place:
        lda HATABS, x
        beq empty_place
        inx
        inx
        inx
        bne next_place
        beq insert
empty_place:
        lda #'N'
        sta HATABS, x
        lda #<null_table
        sta HATABS+1, x
        lda #>null_table
        sta HATABS+2, x
        rts                     ; návrat ze subrutiny
.endproc



; ---------------------------------------------------------------------
; použito jen pro INIT
; ---------------------------------------------------------------------
.proc NULL_HANDLER
        lda #1
        tay
        rts
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
.proc OPEN_CHANNEL_4_AS_N
        ldx #IOCB4              ; offset odvozený od čísla IOCB kanálu
        lda #OPEN               ; prováděná operace
        sta ICCOM, x            ; zápis prováděné operace do bloku IOCB

        ; specifikace jména zařízení + jména souboru (16bitový ukazatel)
        lda #<device_name
        sta ICBAL, x
        lda #>device_name
        sta ICBAH, x

        lda #OPNOT              ; režim otevření: zápis (odpovídá druhému parametru příkazu OPEN v BASICu)
        sta ICAX1, x
        lda #0                  ; odpovídá třetímu parametru příkazu OPEN v BASICu
        sta ICAX2, x

        jsr CIOV                ; zavolání rutiny pro CIO

        rts                     ; návrat ze subrutiny
.endproc



; ---------------------------------------------------------------------
; zápis jednoho znaku do kanálu číslo 4
; ---------------------------------------------------------------------
.proc WRITE_BYTE_CHANNEL_4
        ldx #IOCB4              ; offset odvozený od čísla IOCB kanálu
        lda #PUTCHR             ; prováděná operace
        sta ICCOM, x            ; zápis prováděné operace do bloku IOCB

        ; adresa zapisovaného bloku
        lda #<char_to_put
        sta ICBAL, x
        lda #>char_to_put
        sta ICBAH, x

        ; nastavení počtu zapisovaných bajtů
        lda #1
        sta ICBLL, x
        lda #0
        sta ICBLH, x

        jsr CIOV                ; zavolání rutiny pro CIO
        rts                     ; návrat ze subrutiny
.endproc



; ---------------------------------------------------------------------
; kontrola chyby při zápisu
; ---------------------------------------------------------------------
.proc CHECK_ERROR
        ldx #IOCB4              ; offset odvozený od čísla IOCB kanálu

        lda ICSTA, x            ; status poslední operace
        bpl ok                  ; test bitu 7

        lda #18                 ; kod barvy
        sta COLOR2              ; ulozit do registru COLOR2
        rts                     ; návrat ze subrutiny
ok:
        lda #$c3                ; kod barvy
        sta COLOR2              ; ulozit do registru COLOR2
        rts                     ; návrat ze subrutiny
.endproc



; ---------------------------------------------------------------------
; subrutiny pro realizaci operací zařízení
; ---------------------------------------------------------------------
.proc OPEN_OPERATION
        lda #'o'                ; ATASCII hodnota znaku
        ldy #1                  ; nastavit registr Y
        sta (88),y              ; tisk znaku na obrazovku
        lda #1                  ; chybový kód
        tay                     ; musí být uložen jak v A, tak i v Y
	rts
.endproc



.proc CLOSE_OPERATION
        lda #'c'                ; ATASCII hodnota znaku
        ldy #41                 ; nastavit registr Y
        sta (88),y              ; tisk znaku na obrazovku
        lda #1                  ; chybový kód
        tay                     ; musí být uložen jak v A, tak i v Y
	rts
.endproc



.proc GET_OPERATION
        lda #'g'                ; ATASCII hodnota znaku
        ldy #81                 ; nastavit registr Y
        sta (88),y              ; tisk znaku na obrazovku
        lda #1                  ; chybový kód
        tay                     ; musí být uložen jak v A, tak i v Y
	rts
.endproc



.proc PUT_OPERATION
        lda #'p'                ; ATASCII hodnota znaku
        ldy #121                ; nastavit registr Y
        sta (88),y              ; tisk znaku na obrazovku
        lda #1                  ; chybový kód
        tay                     ; musí být uložen jak v A, tak i v Y
	rts
.endproc



.proc STATUS_OPERATION
        lda #'s'                ; ATASCII hodnota znaku
        ldy #161                ; nastavit registr Y
        sta (88),y              ; tisk znaku na obrazovku
        lda #1                  ; chybový kód
        tay                     ; musí být uložen jak v A, tak i v Y
	rts
.endproc



.proc SPECIAL_OPERATION
        lda #'*'                ; ATASCII hodnota znaku
        ldy #201                ; nastavit registr Y
        sta (88),y              ; tisk znaku na obrazovku
        lda #1                  ; chybový kód
        tay                     ; musí být uložen jak v A, tak i v Y
	rts
.endproc



; jméno zařízení ukončené nulou
device_name: .byte "N:", 0

; zapisovaný bajt
char_to_put: .byte $41

; tabulka s handlerem pro zařízení
null_table:
        .word OPEN_OPERATION-1    ; OPEN
        .word CLOSE_OPERATION-1   ; CLOSE
        .word GET_OPERATION-1     ; GET
        .word PUT_OPERATION-1     ; PUT
        .word STATUS_OPERATION-1  ; STATUS
        .word SPECIAL_OPERATION-1 ; SPECIAL
        jmp NULL_HANDLER          ; inicializace zařízení
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
