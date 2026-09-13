; da65 V2.18 - Fedora 2.19-12.fc42
; Created:    2026-09-04 20:06:07
; Input file: YYY1
; Page:       1


        .setcpu "6502"

L0ED8           := $0ED8
        brk
        brk
        jmp     L0ED8

        ldy     #$01
        sty     $0ED0
        lda     #$EA
        sta     $0ED2
        lda     #$60
        sta     $0ED1
        lda     #$75
        sta     $0ED4
        lda     #$30
        sta     $0ED3
        inc     $0ED0
        inc     $0ED1
        bne     LFFF0
        inc     $0ED2
LFFF0:  inc     $0ED3
        bne     LFFF8
        inc     $0ED4
LFFF8:  rts

        rts

        .byte   $E2
        .byte   $02
        .byte   $E3
        .byte   $02
        cmp     $0E,x
