add_arrays:
        ldp     q24, q26, [x1]
        ldp     q28, q30, [x1, 32]
        ldp     q25, q27, [x0]
        ldp     q29, q31, [x0, 32]
        fadd    v24.8h, v25.8h, v24.8h
        fadd    v26.8h, v27.8h, v26.8h
        fadd    v28.8h, v29.8h, v28.8h
        fadd    v30.8h, v31.8h, v30.8h
        stp     q24, q26, [x0]
        stp     q28, q30, [x0, 32]
        ret
