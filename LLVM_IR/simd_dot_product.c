typedef float  f32x4 __attribute__((vector_size(16)));
typedef double f64x2 __attribute__((vector_size(16)));
typedef __fp16 f16x8 __attribute__((vector_size(16)));

float dot_fp16(f16x8 x , f16x8 y) {
    return x[0] * y[0] + x[1] * y[1] + x[2] * y[2] + x[3] * y[3] +
           x[4] * y[4] + x[5] * y[5] + x[6] * y[6] + x[7] * y[7];
}

float dot_float(f32x4 x, f32x4 y) {
    return x[0] * y[0] + x[1] * y[1] + x[2] * y[2] + x[3] * y[3];
}

double dot_double(f64x2 x, f64x2 y) {
    return x[0] * y[0] + x[1] * y[1];
}
