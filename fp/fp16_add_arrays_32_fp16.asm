add_arrays(_Float16*, _Float16*):
        sub     x2, x0, x1
        sub     x2, x2, #2
        cmp     x2, 12
        bls     .L4
        ldr     q24, [x1]
        ldp     q25, q27, [x0]
        ldp     q29, q31, [x0, 32]
        fadd    v24.8h, v25.8h, v24.8h
        str     q24, [x0]
        ldr     q26, [x1, 16]
        fadd    v26.8h, v27.8h, v26.8h
        str     q26, [x0, 16]
        ldr     q28, [x1, 32]
        fadd    v28.8h, v29.8h, v28.8h
        str     q28, [x0, 32]
        ldr     q30, [x1, 48]
        fadd    v30.8h, v31.8h, v30.8h
        str     q30, [x0, 48]
        ret
.L4:
        mov     x2, 0
.L2:
        ldr     h23, [x0, x2]
        ldr     h22, [x1, x2]
        fadd    h22, h23, h22
        str     h22, [x0, x2]
        add     x2, x2, 2
        cmp     x2, 64
        bne     .L2
        ret
