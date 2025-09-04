#include <stdint.h>

int bit_width_8bit(int8_t x) {
    return __builtin_stdc_bit_width(x);
}

int bit_width_16bit(int16_t x) {
    return __builtin_stdc_bit_width(x);
}

int bit_width_32bit(int32_t x) {
    return __builtin_stdc_bit_width(x);
}

int bit_width_64bit(int64_t x) {
    return __builtin_stdc_bit_width(x);
}

