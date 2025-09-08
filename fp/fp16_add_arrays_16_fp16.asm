add_arrays(_Float16*, _Float16*):
        sub     x2, x0, x1
        sub     x2, x2, #2
        cmp     x2, 12
        bls     .L2
        ldr     q28, [x1]
        ldp     q29, q31, [x0]
        fadd    v28.8h, v29.8h, v28.8h
        str     q28, [x0]
        ldr     q30, [x1, 16]
        fadd    v30.8h, v31.8h, v30.8h
        str     q30, [x0, 16]
        ret
.L2:
        ldr     h20, [x1]
        ldr     h21, [x0]
        ldr     h23, [x0, 2]
        ldr     h25, [x0, 4]
        fadd    h20, h21, h20
        ldr     h27, [x0, 6]
        ldr     h29, [x0, 8]
        ldr     h31, [x0, 10]
        ldr     h1, [x0, 12]
        str     h20, [x0]
        ldr     h22, [x1, 2]
        ldr     h3, [x0, 14]
        ldr     h5, [x0, 16]
        fadd    h22, h23, h22
        ldr     h7, [x0, 18]
        ldr     h17, [x0, 20]
        str     h22, [x0, 2]
        ldr     h24, [x1, 4]
        fadd    h24, h25, h24
        str     h24, [x0, 4]
        ldr     h26, [x1, 6]
        fadd    h26, h27, h26
        str     h26, [x0, 6]
        ldr     h28, [x1, 8]
        fadd    h28, h29, h28
        str     h28, [x0, 8]
        ldr     h30, [x1, 10]
        fadd    h30, h31, h30
        str     h30, [x0, 10]
        ldr     h0, [x1, 12]
        fadd    h0, h1, h0
        str     h0, [x0, 12]
        ldr     h2, [x1, 14]
        fadd    h2, h3, h2
        str     h2, [x0, 14]
        ldr     h4, [x1, 16]
        fadd    h4, h5, h4
        str     h4, [x0, 16]
        ldr     h6, [x1, 18]
        fadd    h6, h7, h6
        str     h6, [x0, 18]
        ldr     h16, [x1, 20]
        fadd    h16, h17, h16
        str     h16, [x0, 20]
        ldr     h18, [x1, 22]
        ldr     h19, [x0, 22]
        ldr     h21, [x0, 24]
        ldr     h23, [x0, 26]
        fadd    h18, h19, h18
        ldr     h25, [x0, 28]
        ldr     h27, [x0, 30]
        str     h18, [x0, 22]
        ldr     h20, [x1, 24]
        fadd    h20, h21, h20
        str     h20, [x0, 24]
        ldr     h22, [x1, 26]
        fadd    h22, h23, h22
        str     h22, [x0, 26]
        ldr     h24, [x1, 28]
        fadd    h24, h25, h24
        str     h24, [x0, 28]
        ldr     h26, [x1, 30]
        fadd    h26, h27, h26
        str     h26, [x0, 30]
        ret
