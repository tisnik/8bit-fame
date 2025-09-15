add:
        ldp     q29, q31, [x0]
        ldp     q28, q30, [x1]
        fadd    v28.8h, v29.8h, v28.8h
        fadd    v30.8h, v31.8h, v30.8h
        stp     q28, q30, [x8]
        ret
