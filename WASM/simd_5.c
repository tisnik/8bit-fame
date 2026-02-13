typedef signed char i8x16 __attribute__((vector_size(16)));

i8x16 add(i8x16 x, i8x16 y) {
    return x + y;
}
