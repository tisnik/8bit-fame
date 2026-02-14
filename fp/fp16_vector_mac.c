typedef _Float16 float16x8 __attribute__((vector_size(16)));

float16x8 mac(float16x8 a, float16x8 b, float16x8 c) {
    return a + b * c;
}
