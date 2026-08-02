; Zdroj:
; https://github.com/ilmenit/AltirraSDL/blob/main/src/Kernel/source/Shared/vbi.s

pot_loop:
        lda             pot0,x
        sta             paddl0,x
        lda             #0
        sta             ptrig0,x
        dex
        bpl             pot_loop
        
        ldx             #3
trig_loop:
        lda             trig0,x
        sta             strig0,x
        dex
        bpl             trig_loop

        lda             porta
        ldx             #0
        ldy             #0
        jsr             do_stick_ptrigs
        lda             portb
        ldx             #4
        ldy             #2
        jsr             do_stick_ptrigs
.endif
        
        ;restart pots (required for SysInfo)
        sta             potgo
