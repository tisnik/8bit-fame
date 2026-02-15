#include <stdbool.h>

bool add_overflow_ccc(unsigned char x, unsigned char y) {
    unsigned char z;
    bool          overflow = __builtin_add_overflow(x, y, &z);
    return overflow;
}

bool add_overflow_cci(unsigned char x, unsigned char y) {
    unsigned int z;
    bool         overflow = __builtin_add_overflow(x, y, &z);
    return overflow;
}

bool add_overflow_cic(unsigned char x, unsigned int y) {
    unsigned char z;
    bool          overflow = __builtin_add_overflow(x, y, &z);
    return overflow;
}

bool add_overflow_cii(unsigned char x, unsigned int y) {
    unsigned int z;
    bool         overflow = __builtin_add_overflow(x, y, &z);
    return overflow;
}

bool add_overflow_icc(unsigned char x, unsigned char y) {
    unsigned char z;
    bool          overflow = __builtin_add_overflow(x, y, &z);
    return overflow;
}

bool add_overflow_ici(unsigned int x, unsigned char y) {
    unsigned int z;
    bool         overflow = __builtin_add_overflow(x, y, &z);
    return overflow;
}

bool add_overflow_iic(unsigned int x, unsigned int y) {
    unsigned char z;
    bool          overflow = __builtin_add_overflow(x, y, &z);
    return overflow;
}

bool add_overflow_iii(unsigned int x, unsigned int y) {
    unsigned int z;
    bool         overflow = __builtin_add_overflow(x, y, &z);
    return overflow;
}
