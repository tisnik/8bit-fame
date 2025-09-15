from_float32x8:
        ldp     s28, s29, [x0, 8]
        ldp     s31, s30, [x0]
        fcvt    h24, s28
        fcvt    h25, s29
        ldp     s26, s27, [x0, 16]
        fcvt    h31, s31
        fcvt    h30, s30
        ldp     s28, s29, [x0, 24]
        fcvt    h26, s26
        fcvt    h27, s27
        ins     v31.h[1], v24.h[0]
        ins     v30.h[1], v25.h[0]
        fcvt    h28, s28
        fcvt    h29, s29
        ins     v31.h[2], v26.h[0]
        ins     v30.h[2], v27.h[0]
        ins     v31.h[3], v28.h[0]
        ins     v30.h[3], v29.h[0]
        zip1    v0.8h, v31.8h, v30.8h
        ret
