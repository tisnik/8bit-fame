parity_char:
        push    {r4, lr}
        bl      __paritysi2
        pop     {r4, lr}
        bx      lr

parity_int:
        push    {r4, lr}
        bl      __paritysi2
        pop     {r4, lr}
        bx      lr

parity_long:
        push    {r4, lr}
        bl      __paritysi2
        pop     {r4, lr}
        bx      lr

parity_long_long:
        push    {r4, lr}
        bl      __paritydi2
        pop     {r4, lr}
        bx      lr
