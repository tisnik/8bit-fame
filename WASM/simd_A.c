typedef signed   char           i8x16 __attribute__((vector_size(16)));
typedef unsigned char           u8x16 __attribute__((vector_size(16)));
typedef signed   short int      i16x8 __attribute__((vector_size(16)));
typedef unsigned short int      u16x8 __attribute__((vector_size(16)));
typedef signed   int            i32x4 __attribute__((vector_size(16)));
typedef unsigned int            u32x4 __attribute__((vector_size(16)));
typedef   signed long long int  i64x2 __attribute__((vector_size(16)));
typedef unsigned long long int  u64x2 __attribute__((vector_size(16)));
typedef float                   f32x4 __attribute__((vector_size(16)));
typedef double                  f64x2 __attribute__((vector_size(16)));
 
#define NEG(type) type neg_##type(type x) {return -x;}
#define ADD(type) type add_##type(type x, type y) {return x+y;}
#define SUB(type) type sub_##type(type x, type y) {return x-y;}
#define MUL(type) type mul_##type(type x, type y) {return x*y;}
#define DIV(type) type div_##type(type x, type y) {return x/y;}

#define ALL(type) \
    NEG(type) \
    ADD(type) \
    SUB(type) \
    MUL(type) \
    DIV(type)

ALL(i8x16)
ALL(u8x16)
ALL(i16x8)
ALL(u16x8)
ALL(i32x4)
ALL(u32x4)
ALL(i64x2)
ALL(u64x2)
ALL(f32x4)
ALL(f64x2)
