; da65 V2.18 - Fedora 2.19-12.fc42
; Created:    2026-09-04 22:12:17
; Input file: YYY
; Page:       1


        .setcpu "6502"

L0EFC           := $0EFC
        ora     $00
        jmp     L0EFC

        lda     #$0A
        sta     $0EF4
        ldy     #$00
        sty     $0EF6
        lda     #$0A
        sta     $0EF5
        sty     $0EF8
        lda     #$0A
        sta     $0EF7
        lsr     $0EF4
        lsr     $0EF6
        ror     $0EF5
        lsr     $0EF8
        ror     $0EF7
        rts

        rts

        .byte   $E2
        .byte   $02
        .byte   $E3
        .byte   $02
        .byte   $F9
        .byte   $0E
