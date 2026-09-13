; da65 V2.18 - Fedora 2.19-12.fc42
; Created:    2026-09-05 11:29:45
; Input file: S111
; Page:       1


        .setcpu "6502"

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
        rts

        rts

        .byte   $E2
        .byte   $02
        .byte   $E3
        .byte   $02
        rol     $0F
