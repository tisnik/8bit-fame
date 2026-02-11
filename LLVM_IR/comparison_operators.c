#define EQ(type) \
    type eq_##type(type x, type y) { return x == y; }
#define NE(type) \
    type ne_##type(type x, type y) { return x != y; }
#define LT(type) \
    type lt_##type(type x, type y) { return x < y; }
#define LE(type) \
    type le_##type(type x, type y) { return x <= y; }
#define GT(type) \
    type gt_##type(type x, type y) { return x > y; }
#define GE(type) \
    type ge_##type(type x, type y) { return x >= y; }

#define ALL(type) \
    EQ(type)      \
    NE(type)      \
    LT(type)      \
    LE(type)      \
    GT(type)      \
    GE(type)

ALL(int)
ALL(unsigned)
