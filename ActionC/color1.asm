; da65 V2.18 - Fedora 2.19-15.fc44
; Created:    2026-11-24 19:58:29
; Input file: color1.obj
; Page:       1


        .setcpu "6502"

L3003           := $3003
        jmp     L3003

        lda     #$2A
        sta     $02C6
        rts

        rts

