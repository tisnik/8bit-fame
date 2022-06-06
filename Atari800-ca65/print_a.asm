.include "atari.inc"

.CODE

.proc main
        lda #33                 ; ATASCII hodnota znaku "A"
	ldy #0                  ; vynulovat registr Y
        sta (88),y		; tisk znaku "A" na první místo na obrazovce
	                        ; (adresa Video RAM je na adresách 88 a 89)
loop:   jmp loop
end:
.endproc
                

.segment "EXEHDR"
.word   $ffff
.word   main
.word   main::end - 1


.segment "AUTOSTRT"
.word   RUNAD                   ; definováno v atari.h
.word   RUNAD+1
.word   main
