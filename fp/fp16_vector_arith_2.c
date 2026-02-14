typedef _Float16 float16x64 __attribute__((vector_size(128)));

float16x64 add(float16x64 x, float16x64 y) {
    return x + y;
}

float16x64 sub(float16x64 x, float16x64 y) {
    return x - y;
}

float16x64 mul(float16x64 x, float16x64 y) {
    return x * y;
}

float16x64 div(float16x64 x, float16x64 y) {
    return x / y;
}
