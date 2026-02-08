float sqrtf(float x);
double sqrt(double x);

typedef float                   f32x4 __attribute__((vector_size(16)));
typedef double                  f64x2 __attribute__((vector_size(16)));
 
f32x4 vector_sqrt_f32x4(f32x4 x) {
    f32x4 result;
    int i;
    for (i=0; i<4; i++) {
        result[i] = sqrtf(x[i]);
    }
    return result;
}
 
f64x2 vector_sqrt_f64x2(f64x2 x) {
    f64x2 result;
    int i;
    for (i=0; i<2; i++) {
        result[i] = sqrt(x[i]);
    }
    return result;
}

