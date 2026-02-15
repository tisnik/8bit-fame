typedef unsigned int i32x4 __attribute__((vector_size(16)));

i32x4 neg(i32x4 x) {
    return -x;
}

i32x4 add(i32x4 x, i32x4 y) {
    return x + y;
}

i32x4 sub(i32x4 x, i32x4 y) {
    return x - y;
}

i32x4 mul(i32x4 x, i32x4 y) {
    return x * y;
}

i32x4 div(i32x4 x, i32x4 y) {
    return x / y;
}

i32x4 rem(i32x4 x, i32x4 y) {
    return x % y;
}
