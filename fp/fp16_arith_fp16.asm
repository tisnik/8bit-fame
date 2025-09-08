fp16_add(_Float16, _Float16):
        fadd    h0, h0, h1
        ret

fp16_sub(_Float16, _Float16):
        fsub    h0, h0, h1
        ret

fp16_mul(_Float16, _Float16):
        fmul    h0, h0, h1
        ret

fp16_div(_Float16, _Float16):
        fdiv    h0, h0, h1
        ret
