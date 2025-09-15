add_delta:
        dup     v1.8h, v1.h[0]
        fadd    v0.8h, v1.8h, v0.8h
        ret
