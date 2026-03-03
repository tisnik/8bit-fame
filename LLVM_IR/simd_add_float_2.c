typedef float  f32x8 __attribute__((vector_size(32)));
typedef double f64x4 __attribute__((vector_size(32)));
typedef __fp16 f16x16 __attribute__((vector_size(32)));

f16x16 add_f16x8(f16x16 x, f16x16 y) {
    return x + y;
}

f32x8 add_f32x8(f32x8 x, f32x8 y) {
    return x + y;
}

f64x4 add_f64x4(f64x4 x, f64x4 y) {
    return x + y;
}
