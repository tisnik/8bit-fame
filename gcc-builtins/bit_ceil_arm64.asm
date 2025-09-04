bit_ceil_8bit:
        and     w0, w0, 255
        cmp     w0, 1
        bls     .L3
        sub     w0, w0, #1
        mov     w2, 31
        and     w0, w0, 255
        mov     w1, 2
        clz     w0, w0
        sub     w0, w2, w0
        lsl     w0, w1, w0
        and     w0, w0, 255
        ret
.L3:
        mov     w0, 1
        ret

bit_ceil_16bit:
        and     w0, w0, 65535
        cmp     w0, 1
        bls     .L7
        sub     w0, w0, #1
        mov     w2, 31
        and     w0, w0, 65535
        mov     w1, 2
        clz     w0, w0
        sub     w0, w2, w0
        lsl     w0, w1, w0
        and     w0, w0, 65535
        ret
.L7:
        mov     w0, 1
        ret

bit_ceil_32bit:
        subs    w2, w0, 1
        mov     w1, 31
        clz     w2, w2
        mov     w0, 2
        sub     w1, w1, w2
        lsl     w0, w0, w1
        csinc   w0, w0, wzr, hi
        ret

bit_ceil_64bit:
        subs    x2, x0, 1
        mov     w1, 63
        clz     x2, x2
        mov     x0, 2
        sub     w1, w1, w2
        lsl     x0, x0, x1
        csinc   w0, w0, wzr, hi
        ret
