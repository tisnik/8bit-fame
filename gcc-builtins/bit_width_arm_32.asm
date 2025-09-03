bit_width_8bit:
        subs    r3, r0, #0
        beq     .L3
        push    {r4, lr}
        bl      __clzsi2
        pop     {r4, lr}
        rsb     r0, r0, #32
        bx      lr
.L3:
        mov     r0, r3
        bx      lr

bit_width_16bit:
        subs    r3, r0, #0
        beq     .L11
        push    {r4, lr}
        bl      __clzsi2
        pop     {r4, lr}
        rsb     r0, r0, #32
        bx      lr
.L11:
        mov     r0, r3
        bx      lr

bit_width_32bit:
        subs    r3, r0, #0
        beq     .L18
        push    {r4, lr}
        bl      __clzsi2
        pop     {r4, lr}
        rsb     r0, r0, #32
        bx      lr
.L18:
        mov     r0, r3
        bx      lr

bit_width_64bit:
        orrs    r3, r0, r1
        beq     .L25
        push    {r4, lr}
        bl      __clzdi2
        pop     {r4, lr}
        rsb     r0, r0, #64
        bx      lr
.L25:
        mov     r0, #0
        bx      lr
