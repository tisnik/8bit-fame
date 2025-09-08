fp16_add:
        fcvt    s1, h1
        fcvt    s0, h0
        fadd    s0, s0, s1
        fcvt    h0, s0
        ret

fp16_sub:
        fcvt    s1, h1
        fcvt    s0, h0
        fsub    s0, s0, s1
        fcvt    h0, s0
        ret

fp16_mul:
        fcvt    s1, h1
        fcvt    s0, h0
        fmul    s0, s0, s1
        fcvt    h0, s0
        ret

fp16_div:
        fcvt    s1, h1
        fcvt    s0, h0
        fdiv    s0, s0, s1
        fcvt    h0, s0
        ret
