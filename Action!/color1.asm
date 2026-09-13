; da65 V2.18 - Fedora 2.19-12.fc42
; Created:    2026-09-05 11:29:18
; Input file: C111
; Page:       1


        .setcpu "6502"

        lda     #$2A
        sta     $02C6
        rts

        rts

        .byte   $E2
        .byte   $02
        .byte   $E3
        .byte   $02
        pla
        .byte   $0E
