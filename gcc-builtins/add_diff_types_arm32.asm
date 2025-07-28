add_overflow_ccc:
        add     r0, r0, r1
        lsrs    r0, r0, #8
        bx      lr

add_overflow_cci:
        movs    r0, #0
        bx      lr

add_overflow_cic:
        adds    r0, r0, r1
        mov     r3, #0
        it      cs
        movcs   r3, #1
        bics    r2, r0, #255
        it      ne
        movne   r3, #1
        and     r0, r3, #1
        bx      lr

add_overflow_cii:
        cmn     r0, r1
        ite     cs
        movcs   r0, #1
        movcc   r0, #0
        bx      lr

add_overflow_icc:
        add     r0, r0, r1
        lsrs    r0, r0, #8
        bx      lr

add_overflow_ici:
        cmn     r1, r0
        ite     cs
        movcs   r0, #1
        movcc   r0, #0
        bx      lr

add_overflow_iic:
        adds    r0, r0, r1
        mov     r3, #0
        it      cs
        movcs   r3, #1
        bics    r2, r0, #255
        it      ne
        movne   r3, #1
        and     r0, r3, #1
        bx      lr

add_overflow_iii:
        cmn     r0, r1
        ite     cs
        movcs   r0, #1
        movcc   r0, #0
        bx      lr
