#define NEG(type) \
    type neg_##type(type x) { return -x; }
#define ADD(type) \
    type add_##type(type x, type y) { return x + y; }
#define SUB(type) \
    type sub_##type(type x, type y) { return x - y; }
#define MUL(type) \
    type mul_##type(type x, type y) { return x * y; }
#define DIV(type) \
    type div_##type(type x, type y) { return x / y; }
#define SHL(type) \
    type shl_##type(type x, type y) { return x << y; }
#define SHR(type) \
    type shr_##type(type x, type y) { return x >> y; }

#define ALL(type) \
    NEG(type)     \
    ADD(type)     \
    SUB(type)     \
    MUL(type)     \
    DIV(type)     \
    SHL(type)     \
    SHR(type)

ALL(int)
ALL(unsigned)
