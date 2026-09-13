; da65 V2.18 - Fedora 2.19-12.fc42
; Created:    2026-09-05 11:29:49
; Input file: S222
; Page:       1


        .setcpu "6502"

L105E           := $105E
L1066           := $1066
L1073           := $1073
L1078           := $1078
L109C           := $109C
        lda     $14
        sta     $105D
        lda     $105D
        eor     $14
        beq     LFFBD
        jmp     L1073

LFFBD:  jmp     L1066

        rts

        brk
        jmp     L1078

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
        sta     $1074
        inc     $1074
        lda     $1074
        sta     $D000
        jsr     L105E
        jmp     L109C

        rts

        rts

        .byte   $E2
        .byte   $02
        .byte   $E3
        .byte   $02
        adc     $10,x
