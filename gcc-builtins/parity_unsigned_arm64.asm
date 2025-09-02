parity_char:
        and     x0, x0, 255
        fmov    d31, x0
        cnt     v31.8b, v31.8b
        addv    b31, v31.8b
        fmov    w0, s31
        and     w0, w0, 1
        ret

parity_int:
        fmov    s31, w0
        cnt     v31.8b, v31.8b
        addv    b31, v31.8b
        fmov    w0, s31
        and     w0, w0, 1
        ret

parity_long:
        fmov    d31, x0
        cnt     v31.8b, v31.8b
        addv    b31, v31.8b
        fmov    x0, d31
        and     w0, w0, 1
        ret

parity_long_long:
        fmov    d31, x0
        cnt     v31.8b, v31.8b
        addv    b31, v31.8b
        fmov    x0, d31
        and     w0, w0, 1
        ret
