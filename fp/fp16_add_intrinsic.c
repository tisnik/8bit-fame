#include <arm_fp16.h>

_Float16 fp16_add(_Float16 x, _Float16 y) {
    return vaddh_f16(x, y);
}
