fp16_delta(_Float16*, _Float16):
        dup     v0.8h, v0.h[0]
        ldp     q3, q2, [x0]
        ldp     q1, q31, [x0, 32]
        fadd    v3.8h, v3.8h, v0.8h
        fadd    v2.8h, v2.8h, v0.8h
        fadd    v1.8h, v1.8h, v0.8h
        fadd    v31.8h, v31.8h, v0.8h
        stp     q3, q2, [x0]
        stp     q1, q31, [x0, 32]
        ret
