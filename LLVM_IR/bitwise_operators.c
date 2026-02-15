#define AND(type) \
    type and_##type(type x, type y) { return x & y; }
#define OR(type) \
    type or_##type(type x, type y) { return x | y; }
#define XOR(type) \
    type xor_##type(type x, type y) { return x ^ y; }

#define ALL(type) \
    AND(type)     \
    OR(type)      \
    XOR(type)

ALL(int)
ALL(unsigned)
