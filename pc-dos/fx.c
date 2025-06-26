#include <stdint.h>

uint32_t fx_add(uint32_t x, uint32_t y) {
    return x+y;
}

uint32_t fx_mul_1(uint32_t x, uint32_t y) {
    return (x>>8) * (y>>8);
}

uint32_t fx_mul_2(uint32_t x, uint32_t y) {
    return (x*y)>>16;
}

