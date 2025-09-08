fp16_eq(_Float16, _Float16):
        fcmeq   h31, h0, h1
        umov    w0, v31.h[0]
        tst     w0, 65535
        cset    w0, ne
        ret

fp16_ne(_Float16, _Float16):
        fcmeq   h31, h0, h1
        umov    w0, v31.h[0]
        tst     w0, 65535
        cset    w0, eq
        ret

fp16_gt(_Float16, _Float16):
        fcmgt   h31, h0, h1
        umov    w0, v31.h[0]
        tst     w0, 65535
        cset    w0, ne
        ret

fp16_ge(_Float16, _Float16):
        fcmge   h31, h0, h1
        umov    w0, v31.h[0]
        tst     w0, 65535
        cset    w0, ne
        ret

fp16_lt(_Float16, _Float16):
        fcmgt   h31, h1, h0
        umov    w0, v31.h[0]
        tst     w0, 65535
        cset    w0, ne
        ret

fp16_le(_Float16, _Float16):
        fcmge   h31, h1, h0
        umov    w0, v31.h[0]
        tst     w0, 65535
        cset    w0, ne
        ret
