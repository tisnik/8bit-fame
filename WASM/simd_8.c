typedef float  f32x4 __attribute__((vector_size(16)));
typedef double f64x2 __attribute__((vector_size(16)));
typedef __fp16 f16x8 __attribute__((vector_size(16)));
 
f16x8 add_f16x8(f16x8 x, f16x8 y) {
    return x+y;
}
 
f32x4 add_f32x4(f32x4 x, f32x4 y) {
    return x+y;
}
 
f64x2 add_f64x2(f64x2 x, f64x2 y) {
    return x+y;
}
