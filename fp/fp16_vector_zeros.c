typedef _Float16  float16x8 __attribute__((vector_size(16)));
typedef short int int16x8 __attribute__((vector_size(16)));

int16x8 zeros(float16x8 x) {
    return x == 0;
}
