bit_width_8bit:
        ands    w0, w0, 255
        mov     w1, 32
        clz     w2, w0
        sub     w0, w1, w2
        csel    w0, w0, wzr, ne
        ret

bit_width_16bit:
        ands    w0, w0, 65535
        mov     w1, 32
        clz     w2, w0
        sub     w0, w1, w2
        csel    w0, w0, wzr, ne
        ret

bit_width_32bit:
        clz     w0, w0
        mov     w1, 32
        sub     w0, w1, w0
        ret

bit_width_64bit:
        clz     x0, x0
        mov     w1, 64
        sub     w0, w1, w0
        ret
