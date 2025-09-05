#include <stdint.h>

int bit_floor_8bit(uint8_t x) {
    return __builtin_stdc_bit_floor(x);
}

int bit_floor_16bit(uint16_t x) {
    return __builtin_stdc_bit_floor(x);
}

int bit_floor_32bit(uint32_t x) {
    return __builtin_stdc_bit_floor(x);
}

int bit_floor_64bit(uint64_t x) {
    return __builtin_stdc_bit_floor(x);
}

