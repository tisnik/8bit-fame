typedef signed char        i8x16 __attribute__((vector_size(16)));
typedef unsigned char      u8x16 __attribute__((vector_size(16)));
typedef signed short int   i16x8 __attribute__((vector_size(16)));
typedef unsigned short int u16x8 __attribute__((vector_size(16)));
typedef signed int         i32x4 __attribute__((vector_size(16)));
typedef unsigned int       u32x4 __attribute__((vector_size(16)));
typedef signed long int    i64x2 __attribute__((vector_size(16)));
typedef unsigned long int  u64x2 __attribute__((vector_size(16)));

float dot_i18x16(i8x16 x , i8x16 y) {
    return x[0] * y[0] + x[1] * y[1] + x[2] * y[2] + x[3] * y[3] +
           x[4] * y[4] + x[5] * y[5] + x[6] * y[6] + x[7] * y[7];
}

float dot_i16x8(i16x8 x, i16x8 y) {
    return x[0] * y[0] + x[1] * y[1] + x[2] * y[2] + x[3] * y[3];
}

double dot_i32x4(i32x4 x, i32x4 y) {
    return x[0] * y[0] + x[1] * y[1];
}

double dot_i64x2(i64x2 x, i64x2 y) {
    return x[0] * y[0];
}

float dot_u18x16(u8x16 x , u8x16 y) {
    return x[0] * y[0] + x[1] * y[1] + x[2] * y[2] + x[3] * y[3] +
           x[4] * y[4] + x[5] * y[5] + x[6] * y[6] + x[7] * y[7];
}

float dot_u16x8(u16x8 x, u16x8 y) {
    return x[0] * y[0] + x[1] * y[1] + x[2] * y[2] + x[3] * y[3];
}

double dot_u32x4(u32x4 x, u32x4 y) {
    return x[0] * y[0] + x[1] * y[1];
}

double dot_u64x2(u64x2 x, u64x2 y) {
    return x[0] * y[0];
}
