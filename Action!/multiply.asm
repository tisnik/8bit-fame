; da65 V2.18 - Fedora 2.19-12.fc42
; Created:    2026-09-04 20:06:03
; Input file: YYY2
; Page:       1


        .setcpu "6502"

L0ED8           := $0ED8
LA000           := $A000
        brk
        brk
        jmp     L0ED8

        lda     #$2A
        sta     $0ED0
        ldy     #$00
        sty     $0ED2
        lda     #$2A
        sta     $0ED1
        sty     $0ED4
        lda     #$2A
        sta     $0ED3
        lda     #$00
        sta     $85
        lda     #$05
        sta     $84
        lda     $0ED0
        ldx     #$00
        jsr     LA000
        sta     $0ED0
        lda     #$00
        sta     $85
        lda     #$05
        sta     $84
        lda     $0ED2
        tax
        lda     $0ED1
        jsr     LA000
        sta     $0ED1
        txa
        sta     $0ED2
        lda     #$00
        sta     $85
        lda     #$05
        sta     $84
        lda     $0ED4
        tax
        lda     $0ED3
        jsr     LA000
        sta     $0ED3
        txa
        sta     $0ED4
        rts

        rts

        .byte   $E2
        .byte   $02
        .byte   $E3
        .byte   $02
        cmp     $0E,x
