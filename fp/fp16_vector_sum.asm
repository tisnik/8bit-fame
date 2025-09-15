sum1:
        movi    v31.4s, 0
        ext     v1.16b, v0.16b, v31.16b, #8
        fadd    v0.8h, v1.8h, v0.8h
        ext     v30.16b, v0.16b, v31.16b, #4
        fadd    v0.8h, v30.8h, v0.8h
        ext     v31.16b, v0.16b, v31.16b, #2
        fadd    v0.8h, v31.8h, v0.8h
        ret

sum2:
        dup     h31, v0.h[1]
        dup     h25, v0.h[2]
        dup     h26, v0.h[3]
        dup     h27, v0.h[4]
        fadd    h31, h31, h0
        dup     h28, v0.h[5]
        dup     h29, v0.h[6]
        dup     h30, v0.h[7]
        fadd    h31, h31, h25
        fadd    h31, h31, h26
        fadd    h31, h31, h27
        fadd    h31, h31, h28
        fadd    h31, h31, h29
        fadd    h0, h31, h30
        ret
