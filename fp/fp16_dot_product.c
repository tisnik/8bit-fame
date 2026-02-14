typedef _Float16 float16x8 __attribute__((vector_size(16)));

_Float16 dot_product(float16x8 a, float16x8 b) {
    int      i;
    _Float16 result = 0.0;
    for (i = 0; i < sizeof(float16x8) / sizeof(_Float16); i++) {
        result += a[i] * b[i];
    }
    return result;
}
