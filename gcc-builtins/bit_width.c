#include <stdint.h>

int bit_width_8bit(uint8_t x) {
    return __builtin_stdc_bit_width(x);
}

int bit_width_16bit(uint16_t x) {
    return __builtin_stdc_bit_width(x);
}

int bit_width_32bit(uint32_t x) {
    return __builtin_stdc_bit_width(x);
}

int bit_width_64bit(uint64_t x) {
    return __builtin_stdc_bit_width(x);
}

