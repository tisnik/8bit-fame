#include <stdint.h>

int bit_ceil_8bit(uint8_t x) {
    return __builtin_stdc_bit_ceil(x);
}

int bit_ceil_16bit(uint16_t x) {
    return __builtin_stdc_bit_ceil(x);
}

int bit_ceil_32bit(uint32_t x) {
    return __builtin_stdc_bit_ceil(x);
}

int bit_ceil_64bit(uint64_t x) {
    return __builtin_stdc_bit_ceil(x);
}
