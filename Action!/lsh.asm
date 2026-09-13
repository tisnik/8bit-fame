; da65 V2.18 - Fedora 2.19-12.fc42
; Created:    2026-09-04 20:15:26
; Input file: YYY
; Page:       1


        .setcpu "6502"

L0EEC           := $0EEC
LB5C0           := $B5C0
        brk
        brk
        jmp     L0EEC

        ldy     #$01
        sty     $0EE4
        dey
        sty     $0EE6
        iny
        sty     $0EE5
        dey
        sty     $0EE8
        iny
        sty     $0EE7
        lda     $0EE4
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        sta     $0EE4
        lda     #$05
        sta     $84
        lda     $0EE6
        tax
        lda     $0EE5
        jsr     LB5C0
        sta     $0EE5
        txa
        sta     $0EE6
        lda     #$05
        sta     $84
        lda     $0EE8
        tax
        lda     $0EE7
        jsr     LB5C0
        sta     $0EE7
        txa
        sta     $0EE8
        rts

        rts

        .byte   $E2
        .byte   $02
        .byte   $E3
        .byte   $02
        sbc     #$0E
