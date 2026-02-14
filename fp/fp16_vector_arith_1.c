typedef _Float16 float16x8 __attribute__((vector_size(16)));

float16x8 add(float16x8 x, float16x8 y) {
    return x + y;
}

float16x8 sub(float16x8 x, float16x8 y) {
    return x - y;
}

float16x8 mul(float16x8 x, float16x8 y) {
    return x * y;
}

float16x8 div(float16x8 x, float16x8 y) {
    return x / y;
}
