rotate_right_8bit:
        and     r1, r1, #7
        rsb     r3, r1, #0
        and     r3, r3, #7
        lsl     r3, r0, r3
        orr     r0, r3, r0, lsr r1
        and     r0, r0, #255
        bx      lr

rotate_right_16bit:
        and     r1, r1, #15
        rsb     r3, r1, #0
        and     r3, r3, #15
        lsl     r3, r0, r3
        orr     r0, r3, r0, lsr r1
        lsl     r0, r0, #16
        lsr     r0, r0, #16
        bx      lr

rotate_right_32bit:
        and     r1, r1, #31
        ror     r0, r0, r1
        bx      lr

rotate_right_64bit:
        push    {r4, lr}
        mov     lr, r0
        and     r2, r2, #63
        rsb     r4, r2, #32
        rsb     r3, r2, #0
        lsr     r0, r0, r2
        and     r3, r3, #63
        orr     r0, r0, r1, lsl r4
        sub     ip, r2, #32
        orr     r0, r0, r1, lsr ip
        sub     r4, r3, #32
        lsl     ip, r1, r3
        orr     r0, r0, lr, lsl r3
        orr     ip, ip, lr, lsl r4
        rsb     r3, r3, #32
        orr     ip, ip, lr, lsr r3
        orr     r1, ip, r1, lsr r2
        pop     {r4, lr}
        bx      lr
