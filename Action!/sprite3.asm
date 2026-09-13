; da65 V2.18 - Fedora 2.19-12.fc42
; Created:    2026-09-04 19:31:00
; Input file: YYY
; Page:       1


        .setcpu "6502"

L10F0           := $10F0
L10F8           := $10F8
L1105           := $1105
L110A           := $110A
L112E           := $112E
L1141           := $1141
L114E           := $114E
LFF37           := $FF37
        lda     $14
        sta     $10EF
        lda     $10EF
        eor     $14
        beq     LFFA0
        jmp     L1105

LFFA0:  jmp     L10F8

        rts

        brk
        jmp     L110A

        lda     #$80
        sta     $D000
        lda     #$05
        asl     a
        asl     a
        asl     a
        asl     a
        sta     $AE
        clc
        lda     $AE
        adc     #$08
        sta     $02C0
        lda     #$FF
        sta     $D00D
        ldy     #$00
        sty     $D010
        lda     #$80
        sta     $1106
        lda     $0278
        eor     #$0B
        beq     LFFD6
        jmp     L1141

LFFD6:  sec
        lda     $1106
        sbc     #$01
        sta     $1106
        lda     $0278
        eor     #$07
        beq     LFFE9
        jmp     L114E

LFFE9:  inc     $1106
        lda     $1106
        sta     $D000
        jsr     L10F0
        jmp     L112E

        rts

        rts

        .byte   $E2
        .byte   $02
        .byte   $E3
        .byte   $02
        .byte   $07
        .byte   $11
