typedef _Float16 float16x8 __attribute__((vector_size(16)));
typedef float    float32x8 __attribute__((vector_size(32)));

float16x8 from_float32x8(float32x8 x) {
    return __builtin_convertvector(x, float16x8);
}
