rotate_left_8bit:
        and     r1, r1, #7
        rsb     r3, r1, #0
        and     r3, r3, #7
        lsr     r3, r0, r3
        orr     r0, r3, r0, lsl r1
        and     r0, r0, #255
        bx      lr

rotate_left_16bit:
        and     r1, r1, #15
        rsb     r3, r1, #0
        and     r3, r3, #15
        lsr     r3, r0, r3
        orr     r0, r3, r0, lsl r1
        lsl     r0, r0, #16
        lsr     r0, r0, #16
        bx      lr

rotate_left_32bit:
        and     r1, r1, #31
        rsb     r1, r1, #32
        ror     r0, r0, r1
        bx      lr

rotate_left_64bit:
        push    {r4, lr}
        mov     lr, r1
        and     r2, r2, #63
        sub     r4, r2, #32
        rsb     r3, r2, #0
        lsl     r1, r1, r2
        and     r3, r3, #63
        orr     r1, r1, r0, lsl r4
        rsb     ip, r2, #32
        orr     r1, r1, r0, lsr ip
        rsb     r4, r3, #32
        lsr     ip, r0, r3
        orr     r1, r1, lr, lsr r3
        orr     ip, ip, lr, lsl r4
        sub     r3, r3, #32
        orr     ip, ip, lr, lsr r3
        orr     r0, ip, r0, lsl r2
        pop     {r4, lr}
        bx      lr
