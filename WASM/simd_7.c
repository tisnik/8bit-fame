typedef signed   char      i8x16 __attribute__((vector_size(16)));
typedef unsigned char      u8x16 __attribute__((vector_size(16)));
typedef signed   short int i16x8 __attribute__((vector_size(16)));
typedef unsigned short int u16x8 __attribute__((vector_size(16)));
typedef signed   int       i32x4 __attribute__((vector_size(16)));
typedef unsigned int       u32x4 __attribute__((vector_size(16)));
typedef   signed long int  i64x2 __attribute__((vector_size(16)));
typedef unsigned long int  u64x2 __attribute__((vector_size(16)));
 
i8x16 add_i8x16(i8x16 x, i8x16 y) {
    return x+y;
}
 
u8x16 add_u8x16(u8x16 x, u8x16 y) {
    return x+y;
}
 
i16x8 add_i16x8(i16x8 x, i16x8 y) {
    return x+y;
}
 
u16x8 add_u16x8(u16x8 x, u16x8 y) {
    return x+y;
}

i32x4 add_i32x4(i32x4 x, i32x4 y) {
    return x+y;
}
 
u32x4 add_u32x4(u32x4 x, u32x4 y) {
    return x+y;
}

i64x2 add_i64x2(i64x2 x, i64x2 y) {
    return x+y;
}
 
u64x2 add_u64x2(u64x2 x, u64x2 y) {
    return x+y;
}

