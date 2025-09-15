add:
        ldp     q17, q19, [x0]
        ldp     q16, q18, [x1]
        ldp     q21, q23, [x0, 32]
        ldp     q20, q22, [x1, 32]
        ldp     q25, q27, [x0, 64]
        ldp     q24, q26, [x1, 64]
        ldp     q29, q31, [x0, 96]
        ldp     q28, q30, [x1, 96]
        fadd    v16.8h, v17.8h, v16.8h
        fadd    v18.8h, v19.8h, v18.8h
        fadd    v20.8h, v21.8h, v20.8h
        fadd    v22.8h, v23.8h, v22.8h
        fadd    v24.8h, v25.8h, v24.8h
        fadd    v26.8h, v27.8h, v26.8h
        stp     q16, q18, [x8]
        fadd    v28.8h, v29.8h, v28.8h
        stp     q20, q22, [x8, 32]
        fadd    v30.8h, v31.8h, v30.8h
        stp     q24, q26, [x8, 64]
        stp     q28, q30, [x8, 96]
        ret

sub:
        ldp     q17, q19, [x0]
        ldp     q16, q18, [x1]
        ldp     q21, q23, [x0, 32]
        ldp     q20, q22, [x1, 32]
        ldp     q25, q27, [x0, 64]
        ldp     q24, q26, [x1, 64]
        ldp     q29, q31, [x0, 96]
        ldp     q28, q30, [x1, 96]
        fsub    v16.8h, v17.8h, v16.8h
        fsub    v18.8h, v19.8h, v18.8h
        fsub    v20.8h, v21.8h, v20.8h
        fsub    v22.8h, v23.8h, v22.8h
        fsub    v24.8h, v25.8h, v24.8h
        fsub    v26.8h, v27.8h, v26.8h
        stp     q16, q18, [x8]
        fsub    v28.8h, v29.8h, v28.8h
        stp     q20, q22, [x8, 32]
        fsub    v30.8h, v31.8h, v30.8h
        stp     q24, q26, [x8, 64]
        stp     q28, q30, [x8, 96]
        ret

mul:
        ldp     q17, q19, [x0]
        ldp     q16, q18, [x1]
        ldp     q21, q23, [x0, 32]
        ldp     q20, q22, [x1, 32]
        ldp     q25, q27, [x0, 64]
        ldp     q24, q26, [x1, 64]
        ldp     q29, q31, [x0, 96]
        ldp     q28, q30, [x1, 96]
        fmul    v16.8h, v17.8h, v16.8h
        fmul    v18.8h, v19.8h, v18.8h
        fmul    v20.8h, v21.8h, v20.8h
        fmul    v22.8h, v23.8h, v22.8h
        fmul    v24.8h, v25.8h, v24.8h
        fmul    v26.8h, v27.8h, v26.8h
        stp     q16, q18, [x8]
        fmul    v28.8h, v29.8h, v28.8h
        stp     q20, q22, [x8, 32]
        fmul    v30.8h, v31.8h, v30.8h
        stp     q24, q26, [x8, 64]
        stp     q28, q30, [x8, 96]
        ret

div:
        ldp     q17, q19, [x0]
        ldp     q16, q18, [x1]
        ldp     q21, q23, [x0, 32]
        ldp     q20, q22, [x1, 32]
        ldp     q25, q27, [x0, 64]
        ldp     q24, q26, [x1, 64]
        ldp     q29, q31, [x0, 96]
        ldp     q28, q30, [x1, 96]
        fdiv    v16.8h, v17.8h, v16.8h
        fdiv    v18.8h, v19.8h, v18.8h
        fdiv    v20.8h, v21.8h, v20.8h
        fdiv    v22.8h, v23.8h, v22.8h
        fdiv    v24.8h, v25.8h, v24.8h
        fdiv    v26.8h, v27.8h, v26.8h
        stp     q16, q18, [x8]
        fdiv    v28.8h, v29.8h, v28.8h
        fdiv    v30.8h, v31.8h, v30.8h
        stp     q20, q22, [x8, 32]
        stp     q24, q26, [x8, 64]
        stp     q28, q30, [x8, 96]
        ret
