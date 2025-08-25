#include <stdint.h>

uint8_t rotate_right_8bit(uint8_t x, uint8_t y) {
    uint8_t z;
    z = __builtin_stdc_rotate_right(x, y);
    return z;
}

uint16_t rotate_right_16bit(uint16_t x, uint16_t y) {
    uint16_t z;
    z = __builtin_stdc_rotate_right(x, y);
    return z;
}

uint32_t rotate_right_32bit(uint32_t x, uint32_t y) {
    uint32_t z;
    z = __builtin_stdc_rotate_right(x, y);
    return z;
}

uint64_t rotate_right_64bit(uint64_t x, uint64_t y) {
    uint64_t z;
    z = __builtin_stdc_rotate_right(x, y);
    return z;
}

