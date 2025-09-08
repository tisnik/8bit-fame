fp16_delta:
        fcvt    s0, h0
        add     x1, x0, 64
.L2:
        ldr     h31, [x0]
        fcvt    s31, h31
        fadd    s31, s31, s0
        fcvt    h31, s31
        str     h31, [x0], 2
        cmp     x0, x1
        bne     .L2
        ret
