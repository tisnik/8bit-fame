fp16_eq(_Float16, _Float16):
        fcvt    s0, h0
        fcvt    s1, h1
        fcmp    s0, s1
        cset    w0, eq
        ret

fp16_ne(_Float16, _Float16):
        fcvt    s0, h0
        fcvt    s1, h1
        fcmp    s0, s1
        cset    w0, ne
        ret

fp16_gt(_Float16, _Float16):
        fcvt    s0, h0
        fcvt    s1, h1
        fcmpe   s0, s1
        cset    w0, gt
        ret

fp16_ge(_Float16, _Float16):
        fcvt    s0, h0
        fcvt    s1, h1
        fcmpe   s0, s1
        cset    w0, ge
        ret

fp16_lt(_Float16, _Float16):
        fcvt    s0, h0
        fcvt    s1, h1
        fcmpe   s0, s1
        cset    w0, mi
        ret

fp16_le(_Float16, _Float16):
        fcvt    s0, h0
        fcvt    s1, h1
        fcmpe   s0, s1
        cset    w0, ls
        ret
