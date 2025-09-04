bit_ceil_8bit:
        cmp     r0, #1
        bls     .L3
        sub     r0, r0, #1
        push    {r4, lr}
        and     r0, r0, #255
        bl      __clzsi2
        mov     r3, #2
        rsb     r0, r0, #31
        lsl     r0, r3, r0
        and     r0, r0, #255
        pop     {r4, lr}
        bx      lr
.L3:
        mov     r0, #1
        bx      lr

bit_ceil_16bit:
        cmp     r0, #1
        bls     .L11
        sub     r0, r0, #1
        lsl     r0, r0, #16
        push    {r4, lr}
        lsr     r0, r0, #16
        bl      __clzsi2
        mov     r3, #131072
        rsb     r0, r0, #31
        lsl     r0, r3, r0
        lsr     r0, r0, #16
        pop     {r4, lr}
        bx      lr
.L11:
        mov     r0, #1
        bx      lr

bit_ceil_32bit:
        cmp     r0, #1
        bls     .L18
        push    {r4, lr}
        sub     r0, r0, #1
        bl      __clzsi2
        mov     r3, #2
        rsb     r0, r0, #31
        lsl     r0, r3, r0
        pop     {r4, lr}
        bx      lr
.L18:
        mov     r0, #1
        bx      lr

bit_ceil_64bit:
        cmp     r0, #2
        sbcs    r3, r1, #0
        bcc     .L25
        subs    r0, r0, #1
        push    {r4, lr}
        sbc     r1, r1, #0
        bl      __clzdi2
        mov     r3, #2
        rsb     r0, r0, #63
        lsl     r0, r3, r0
        pop     {r4, lr}
        bx      lr
.L25:
        mov     r0, #1
        bx      lr
