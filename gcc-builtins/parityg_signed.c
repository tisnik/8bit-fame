#include <stdint.h>

int parity_8bit(int8_t x) {
    return __builtin_parityg(x);
}

int parity_16bit(int16_t x) {
    return __builtin_parityg(x);
}

int parity_32bit(int32_t x) {
    return __builtin_parityg(x);
}

int parity_64bit(int64_t x) {
    return __builtin_parityg(x);
}
