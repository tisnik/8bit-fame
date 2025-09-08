fp16_add:
        fcvt    s1, h1
        fcvt    s0, h0
        fadd    s0, s0, s1
        fcvt    h0, s0
        ret
