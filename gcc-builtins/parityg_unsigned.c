#include <stdint.h>

int parity_8bit(uint8_t x) {
    return __builtin_parityg(x);
}

int parity_16bit(uint16_t x) {
    return __builtin_parityg(x);
}

int parity_32bit(uint32_t x) {
    return __builtin_parityg(x);
}

int parity_64bit(uint64_t x) {
    return __builtin_parityg(x);
}
