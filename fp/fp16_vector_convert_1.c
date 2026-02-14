typedef _Float16 float16x8 __attribute__((vector_size(16)));
typedef float    float32x8 __attribute__((vector_size(32)));

float32x8 to_float32x8(float16x8 x) {
    return __builtin_convertvector(x, float32x8);
}
