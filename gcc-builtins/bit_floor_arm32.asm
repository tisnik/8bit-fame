bit_floor_8bit:
        subs    r3, r0, #0
        beq     .L3
        push    {r4, lr}
        bl      __clzsi2
        mov     r3, #1
        rsb     r0, r0, #31
        lsl     r0, r3, r0
        and     r0, r0, #255
        pop     {r4, lr}
        bx      lr
.L3:
        mov     r0, r3
        bx      lr

bit_floor_16bit:
        subs    r3, r0, #0
        beq     .L11
        push    {r4, lr}
        bl      __clzsi2
        mov     r3, #65536
        rsb     r0, r0, #31
        lsl     r0, r3, r0
        lsr     r0, r0, #16
        pop     {r4, lr}
        bx      lr
.L11:
        mov     r0, r3
        bx      lr

bit_floor_32bit:
        subs    r3, r0, #0
        beq     .L22
        push    {r4, lr}
        bl      __clzsi2
        mov     r3, #-2147483648
        lsr     r3, r3, r0
        mov     r0, r3
        pop     {r4, lr}
        bx      lr
.L22:
        mov     r0, r3
        bx      lr

bit_floor_64bit:
        orrs    r3, r0, r1
        beq     .L27
        push    {r4, lr}
        bl      __clzdi2
        mov     r1, #-2147483648
        rsb     r3, r0, #32
        sub     r2, r0, #32
        lsl     r0, r1, r3
        orr     r0, r0, r1, lsr r2
        pop     {r4, lr}
        bx      lr
.L27:
        mov     r0, #0
        bx      lr
