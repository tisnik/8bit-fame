; da65 V2.18 - Fedora 2.19-12.fc42
; Created:    2026-09-10 22:04:58
; Input file: OBJ2
; Page:       1


        .setcpu "6502"

L10F8           := $10F8
L10FB           := $10FB
L1108           := $1108
L1114           := $1114
L117E           := $117E
L11A8           := $11A8
L11DD           := $11DD
L120E           := $120E
L2E30           := $2E30
L4553           := $4553
L4E49           := $4E49
LA000           := $A000
LA090           := $A090
LA46C           := $A46C
LA47F           := $A47F
LA4E6           := $A4E6
LA654           := $A654
LA777           := $A777
        lda     #$06
        cmp     $D01F
        bcc     LFEE5
        jmp     L1108

LFEE5:  jmp     L10FB

        rts

        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        jmp     L1114

        ldy     #$00
        sty     $12
        sty     $13
        sty     $14
        lda     #$08
        jsr     LA654
        lda     $59
        sta     $110C
        lda     $58
        sta     $110B
        lda     #$00
        sta     $85
        lda     #$08
        sta     $84
        lda     #$01
        tax
        lda     #$40
        jsr     LA090
        sta     $AE
        txa
        sta     $AF
        lda     #$00
        sta     $85
        lda     #$A0
        sta     $84
        lda     $AF
        tax
        lda     $AE
        jsr     LA000
        sta     $AC
        txa
        sta     $AD
        clc
        lda     $110B
        adc     $AC
        sta     $110D
        lda     $110C
        adc     $AD
        sta     $110E
        lda     $110C
        sta     $1110
        lda     $110B
        sta     $110F
        lda     $110D
        sta     $118F
        lda     $110E
        sta     $1190
LFF5E:  lda     $118F
        cmp     $110F
        lda     $1190
        sbc     $1110
        bcs     LFF71
        jmp     L11A8

        brk
        brk
LFF71:  ldy     $D20A
        ldx     $1110
        lda     $110F
        jsr     LA777
        inc     $110F
        bne     LFF5E
        inc     $1110
        jmp     L117E

        lda     #$01
        sta     $85
        lda     #$00
        sta     $84
        lda     $13
        ldx     #$00
        jsr     LA000
        sta     $AE
        txa
        sta     $AF
        clc
        lda     $AE
        adc     $14
        sta     $1109
        lda     $AF
        adc     #$00
        sta     $110A
        jmp     L11DD

        asl     $4946
        lsr     $5349
        pha
        eor     $44
        jsr     L4E49
        jsr     L2E30
        ldx     #$11
        lda     #$CE
        jsr     LA47F
        lda     #$00
        sta     $85
        lda     #$05
        sta     $84
        lda     $110A
        tax
        lda     $1109
        jsr     LA090
        sta     $A0
        txa
        sta     $A1
        ldx     $A1
        lda     $A0
        jsr     LA4E6
        jmp     L120E

        php
        jsr     L4553
        .byte   $43
        .byte   $4F
        lsr     $5344
        ldx     #$12
        lda     #$05
        jsr     LA46C
        jsr     L10F8
        rts

        rts

        .byte   $E2
        .byte   $02
        .byte   $E3
        .byte   $02
        ora     ($11),y
