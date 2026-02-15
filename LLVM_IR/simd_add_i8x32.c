typedef signed char i8x32 __attribute__((vector_size(32)));

i8x32 add(i8x32 x, i8x32 y) {
    return x + y;
}
