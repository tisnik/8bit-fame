add_overflow_signed_char:
        add     r0, r0, r1
        sxtb    r3, r0
        subs    r0, r0, r3
        it      ne
        movne   r0, #1
        bx      lr
add_overflow_unsigned_char:
        add     r0, r0, r1
        lsrs    r0, r0, #8
        bx      lr
add_overflow_signed_short:
        add     r0, r0, r1
        sxth    r3, r0
        subs    r0, r0, r3
        it      ne
        movne   r0, #1
        bx      lr
add_overflow_unsigned_short:
        add     r0, r0, r1
        lsrs    r0, r0, #16
        bx      lr
add_overflow_signed_int:
        adds    r0, r0, r1
        ite     vs
        movvs   r0, #1
        movvc   r0, #0
        bx      lr
add_overflow_unsigned_int:
        cmn     r0, r1
        ite     cs
        movcs   r0, #1
        movcc   r0, #0
        bx      lr
add_overflow_signed_long:
        adds    r0, r0, r1
        ite     vs
        movvs   r0, #1
        movvc   r0, #0
        bx      lr
add_overflow_unsigned_long:
        cmn     r0, r1
        ite     cs
        movcs   r0, #1
        movcc   r0, #0
        bx      lr
