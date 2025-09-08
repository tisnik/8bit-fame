add_arrays(_Float16*, _Float16*):
        ldr     h24, [x1]
        ldr     h25, [x0]
        ldr     h27, [x0, 2]
        fcvt    s24, h24
        ldr     h29, [x0, 4]
        fcvt    s25, h25
        ldr     h31, [x0, 6]
        fcvt    s27, h27
        ldr     h1, [x0, 8]
        fcvt    s29, h29
        ldr     h3, [x0, 10]
        fcvt    s31, h31
        ldr     h5, [x0, 12]
        fadd    s24, s25, s24
        fcvt    s1, h1
        fcvt    s3, h3
        ldr     h7, [x0, 14]
        fcvt    s5, h5
        ldr     h17, [x0, 16]
        ldr     h19, [x0, 18]
        fcvt    h24, s24
        fcvt    s7, h7
        fcvt    s17, h17
        ldr     h21, [x0, 20]
        fcvt    s19, h19
        str     h24, [x0]
        fcvt    s21, h21
        ldr     h26, [x1, 2]
        fcvt    s26, h26
        fadd    s26, s27, s26
        fcvt    h26, s26
        str     h26, [x0, 2]
        ldr     h28, [x1, 4]
        fcvt    s28, h28
        fadd    s28, s29, s28
        fcvt    h28, s28
        str     h28, [x0, 4]
        ldr     h30, [x1, 6]
        fcvt    s30, h30
        fadd    s30, s31, s30
        fcvt    h30, s30
        str     h30, [x0, 6]
        ldr     h0, [x1, 8]
        fcvt    s0, h0
        fadd    s0, s1, s0
        fcvt    h0, s0
        str     h0, [x0, 8]
        ldr     h2, [x1, 10]
        fcvt    s2, h2
        fadd    s2, s3, s2
        fcvt    h2, s2
        str     h2, [x0, 10]
        ldr     h4, [x1, 12]
        fcvt    s4, h4
        fadd    s4, s5, s4
        fcvt    h4, s4
        str     h4, [x0, 12]
        ldr     h6, [x1, 14]
        fcvt    s6, h6
        fadd    s6, s7, s6
        fcvt    h6, s6
        str     h6, [x0, 14]
        ldr     h16, [x1, 16]
        fcvt    s16, h16
        fadd    s16, s17, s16
        fcvt    h16, s16
        str     h16, [x0, 16]
        ldr     h18, [x1, 18]
        fcvt    s18, h18
        fadd    s18, s19, s18
        fcvt    h18, s18
        str     h18, [x0, 18]
        ldr     h20, [x1, 20]
        fcvt    s20, h20
        fadd    s20, s21, s20
        fcvt    h20, s20
        str     h20, [x0, 20]
        ldr     h22, [x1, 22]
        ldr     h23, [x0, 22]
        ldr     h25, [x0, 24]
        fcvt    s22, h22
        ldr     h27, [x0, 26]
        fcvt    s23, h23
        ldr     h29, [x0, 28]
        fcvt    s25, h25
        ldr     h31, [x0, 30]
        fcvt    s27, h27
        fcvt    s29, h29
        fadd    s22, s23, s22
        fcvt    s31, h31
        fcvt    h22, s22
        str     h22, [x0, 22]
        ldr     h24, [x1, 24]
        fcvt    s24, h24
        fadd    s24, s25, s24
        fcvt    h24, s24
        str     h24, [x0, 24]
        ldr     h26, [x1, 26]
        fcvt    s26, h26
        fadd    s26, s27, s26
        fcvt    h26, s26
        str     h26, [x0, 26]
        ldr     h28, [x1, 28]
        fcvt    s28, h28
        fadd    s28, s29, s28
        fcvt    h28, s28
        str     h28, [x0, 28]
        ldr     h30, [x1, 30]
        fcvt    s30, h30
        fadd    s30, s31, s30
        fcvt    h30, s30
        str     h30, [x0, 30]
        ret
