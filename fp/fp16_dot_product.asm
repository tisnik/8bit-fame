dot_product:
        movi    v31.4s, 0
        fmul    v0.8h, v0.8h, v1.8h
        ext     v2.16b, v0.16b, v31.16b, #8
        fadd    v0.8h, v2.8h, v0.8h
        ext     v1.16b, v0.16b, v31.16b, #4
        fadd    v0.8h, v1.8h, v0.8h
        ext     v31.16b, v0.16b, v31.16b, #2
        fadd    v0.8h, v31.8h, v0.8h
        ret
