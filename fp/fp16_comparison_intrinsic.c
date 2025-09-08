#include <arm_fp16.h>

bool fp16_eq(_Float16 x, _Float16 y) {
    return vceqh_f16(x, y);
}

bool fp16_ne(_Float16 x, _Float16 y) {
    return !vceqh_f16(x, y);
}

bool fp16_gt(_Float16 x, _Float16 y) {
    return vcgth_f16(x, y);
}

bool fp16_ge(_Float16 x, _Float16 y) {
    return vcgeh_f16(x, y);
}

bool fp16_lt(_Float16 x, _Float16 y) {
    return vclth_f16(x, y);
}

bool fp16_le(_Float16 x, _Float16 y) {
    return vcleh_f16(x, y);
}
