add_arrays(_Float16*, _Float16*):
        mov     x2, 0
.L2:
        ldr     h31, [x0, x2]
        ldr     h30, [x1, x2]
        fcvt    s31, h31
        fcvt    s30, h30
        fadd    s30, s31, s30
        fcvt    h30, s30
        str     h30, [x0, x2]
        add     x2, x2, 2
        cmp     x2, 64
        bne     .L2
        ret
