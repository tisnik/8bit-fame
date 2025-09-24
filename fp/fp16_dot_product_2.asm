dot_product:
        dup     h30, v1.h[1]
        dup     h31, v0.h[1]
        dup     h19, v0.h[2]
        dup     h20, v1.h[2]
        dup     h21, v0.h[3]
        dup     h22, v1.h[3]
        fmul    h31, h31, h30
        dup     h23, v0.h[4]
        fmadd   h31, h1, h0, h31
        dup     h24, v1.h[4]
        dup     h25, v0.h[5]
        dup     h26, v1.h[5]
        fmadd   h31, h19, h20, h31
        dup     h27, v0.h[6]
        dup     h28, v1.h[6]
        dup     h29, v0.h[7]
        fmadd   h31, h21, h22, h31
        dup     h30, v1.h[7]
        fmadd   h31, h23, h24, h31
        fmadd   h31, h25, h26, h31
        fmadd   h31, h27, h28, h31
        fmadd   h0, h29, h30, h31
        ret
