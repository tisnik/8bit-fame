rotate_left_8bit:
        and     w1, w1, 7
        and     w0, w0, 255
        neg     w2, w1
        and     w2, w2, 7
        lsr     w1, w0, w1
        lsl     w0, w0, w2
        orr     w0, w1, w0
        ret

rotate_left_16bit:
        and     w1, w1, 15
        and     w0, w0, 65535
        neg     w2, w1
        and     w2, w2, 15
        lsr     w1, w0, w1
        lsl     w0, w0, w2
        orr     w0, w1, w0
        ret

rotate_left_32bit:
        ror     w0, w0, w1
        ret

rotate_left_64bit:
        ror     x0, x0, x1
        ret
