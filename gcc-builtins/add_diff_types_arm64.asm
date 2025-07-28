add_overflow_ccc:
        and     w0, w0, 255
        add     w1, w0, w1
        cmp     w0, w1, uxtb
        cset    w0, hi
        ret

add_overflow_cci:
        mov     w0, 0
        ret

add_overflow_cic:
        uxtw    x1, w1
        add     x1, x1, w0, uxtb
        tst     x1, -256
        cset    w0, ne
        ret

add_overflow_cii:
        and     w0, w0, 255
        adds    w0, w0, w1
        cset    w0, cs
        ret

add_overflow_icc:
        and     w0, w0, 255
        add     w1, w0, w1
        cmp     w0, w1, uxtb
        cset    w0, hi
        ret

add_overflow_ici:
        and     w1, w1, 255
        adds    w1, w1, w0
        cset    w0, cs
        ret

add_overflow_iic:
        uxtw    x1, w1
        add     x0, x1, w0, uxtw
        tst     x0, -256
        cset    w0, ne
        ret

add_overflow_iii:
        adds    w0, w0, w1
        cset    w0, cs
        ret
