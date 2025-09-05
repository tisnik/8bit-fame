bit_floor_8bit:
        ands    w0, w0, 255
        mov     w2, 31
        clz     w3, w0
        mov     w1, 1
        sub     w2, w2, w3
        lsl     w0, w1, w2
        and     w0, w0, 255
        csel    w0, w0, wzr, ne
        ret

bit_floor_16bit:
        ands    w0, w0, 65535
        mov     w2, 31
        clz     w3, w0
        mov     w1, 1
        sub     w2, w2, w3
        lsl     w0, w1, w2
        and     w0, w0, 65535
        csel    w0, w0, wzr, ne
        ret

bit_floor_32bit:
        clz     w2, w0
        cmp     w0, 0
        mov     w1, -2147483648
        lsr     w1, w1, w2
        csel    w0, w1, w0, ne
        ret

bit_floor_64bit:
        clz     x2, x0
        cmp     x0, 0
        mov     x1, -9223372036854775808
        lsr     x0, x1, x2
        csel    w0, w0, wzr, ne
        ret
