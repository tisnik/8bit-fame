#define REM(type) \
    type remainder_##type(type x, type y) { return x % y; }

#define ALL(type) REM(type)

ALL(int)
ALL(unsigned)
