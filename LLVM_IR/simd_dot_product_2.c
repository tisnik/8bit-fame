typedef float  f32x4 __attribute__((vector_size(16)));
typedef double f64x2 __attribute__((vector_size(16)));
typedef __fp16 f16x8 __attribute__((vector_size(16)));

float dot_fp16(f16x8 x, f16x8 y) {
    int i;
    __fp16 result = 0.0;
    for (i = 0; i < sizeof(f16x8) / sizeof(__fp16); i++) {
        result += x[i] * y[i];
    }
    return result;
}

float dot_float(f32x4 x, f32x4 y) {
    int   i;
    float result = 0.0;
    for (i = 0; i < sizeof(f32x4) / sizeof(float); i++) {
        result += x[i] * y[i];
    }
    return result;
}

double dot_double(f64x2 x, f64x2 y) {
    int    i;
    double result = 0.0;
    for (i = 0; i < sizeof(f64x2) / sizeof(double); i++) {
        result += x[i] * y[i];
    }
    return result;
}
