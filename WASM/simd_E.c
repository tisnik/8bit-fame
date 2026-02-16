typedef float  f32x4 __attribute__((vector_size(16)));
typedef double f64x2 __attribute__((vector_size(16)));

float dot_float(f32x4 x, f32x4 y) {
    return x[0] * y[0] + x[1] * y[1] + x[2] * y[2] + x[3] * y[3];
}

double dot_double(f64x2 x, f64x2 y) {
    return x[0] * y[0] + x[1] * y[1];
}
