zeros:
        dup     h30, v0.h[1]
        dup     h24, v0.h[3]
        dup     h25, v0.h[2]
        dup     h26, v0.h[5]
        dup     h27, v0.h[4]
        fcvt    s29, h0
        fcvt    s30, h30
        fcvt    s24, h24
        fcvt    s25, h25
        dup     h28, v0.h[7]
        dup     h31, v0.h[6]
        fcvt    s26, h26
        fcmeq   s0, s29, 0
        fcmeq   s24, s24, 0
        fcmeq   s25, s25, 0
        fcvt    s27, h27
        fcmeq   s30, s30, 0
        fcvt    s28, h28
        fcvt    s31, h31
        fcmeq   s26, s26, 0
        ins     v0.h[1], v25.h[0]
        fcmeq   s27, s27, 0
        ins     v30.h[1], v24.h[0]
        fcmeq   s28, s28, 0
        fcmeq   s31, s31, 0
        ins     v30.h[2], v26.h[0]
        ins     v0.h[2], v27.h[0]
        ins     v30.h[3], v28.h[0]
        ins     v0.h[3], v31.h[0]
        zip1    v0.8h, v0.8h, v30.8h
        ret
