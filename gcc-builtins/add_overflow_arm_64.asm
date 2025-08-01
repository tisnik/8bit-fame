add_overflow_signed_char:
        sxtb    w1, w1
        sxtb    w0, w0
        add     w2, w0, w1
        eon     w0, w0, w1
        eor     w1, w1, w2
        and     w0, w1, w0
        ubfx    w0, w0, 7, 1
        ret
add_overflow_unsigned_char:
        and     w0, w0, 255
        add     w1, w0, w1
        cmp     w0, w1, uxtb
        cset    w0, hi
        ret
add_overflow_signed_short:
        sxth    w1, w1
        sxth    w0, w0
        add     w2, w0, w1
        eon     w0, w0, w1
        eor     w1, w1, w2
        and     x0, x1, x0
        ubfx    x0, x0, 15, 1
        ret
add_overflow_unsigned_short:
        and     w0, w0, 65535
        add     w1, w0, w1
        cmp     w0, w1, uxth
        cset    w0, hi
        ret
add_overflow_signed_int:
        cmn     w0, w1
        cset    w0, vs
        ret
add_overflow_unsigned_int:
        adds    w0, w0, w1
        cset    w0, cs
        ret
add_overflow_signed_long:
        cmn     x0, x1
        cset    w0, vs
        ret
add_overflow_unsigned_long:
        cmn     x0, x1
        cset    w0, cs
        ret
