#define EQ(type) int eq_##type(type x, type y) {return x==y;}
#define NE(type) int ne_##type(type x, type y) {return x!=y;}
#define LT(type) int lt_##type(type x, type y) {return x<y;}
#define LE(type) int le_##type(type x, type y) {return x<=y;}
#define GT(type) int gt_##type(type x, type y) {return x>y;}
#define GE(type) int ge_##type(type x, type y) {return x>=y;}

#define ALL(type) \
    EQ(type) \
    NE(type) \
    LT(type) \
    LE(type) \
    GT(type) \
    GE(type)

ALL(float)
ALL(double)
