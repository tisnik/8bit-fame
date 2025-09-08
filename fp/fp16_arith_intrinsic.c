#include <arm_fp16.h>

_Float16 fp16_add(_Float16 x, _Float16 y) {
    return vaddh_f16(x, y);
}

_Float16 fp16_sub(_Float16 x, _Float16 y) {
    return vsubh_f16(x, y);
}

_Float16 fp16_mul(_Float16 x, _Float16 y) {
    return vmulh_f16(x, y);
}

_Float16 fp16_div(_Float16 x, _Float16 y) {
    return vdivh_f16(x, y);
}
