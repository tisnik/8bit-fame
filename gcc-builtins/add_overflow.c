#include <stdbool.h>

bool add_overflow_signed_char(signed char x, signed char y) {
    signed char z;
    bool        overflow = __builtin_add_overflow(x, y, &z);
    return overflow;
}

bool add_overflow_unsigned_char(unsigned char x, unsigned char y) {
    unsigned char z;
    bool          overflow = __builtin_add_overflow(x, y, &z);
    return overflow;
}

bool add_overflow_signed_short(signed short x, signed short y) {
    signed short z;
    bool         overflow = __builtin_add_overflow(x, y, &z);
    return overflow;
}

bool add_overflow_unsigned_short(unsigned short x, unsigned short y) {
    unsigned short z;
    bool           overflow = __builtin_add_overflow(x, y, &z);
    return overflow;
}

bool add_overflow_signed_int(signed int x, signed int y) {
    signed int z;
    bool       overflow = __builtin_add_overflow(x, y, &z);
    return overflow;
}

bool add_overflow_unsigned_int(unsigned int x, unsigned int y) {
    unsigned int z;
    bool         overflow = __builtin_add_overflow(x, y, &z);
    return overflow;
}

bool add_overflow_signed_long(signed long x, signed long y) {
    signed long z;
    bool        overflow = __builtin_add_overflow(x, y, &z);
    return overflow;
}

bool add_overflow_unsigned_long(unsigned long x, unsigned long y) {
    unsigned long z;
    bool          overflow = __builtin_add_overflow(x, y, &z);
    return overflow;
}
