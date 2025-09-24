typedef _Float16 float16x8 __attribute__((vector_size(16)));

_Float16 dot_product(float16x8 a, float16x8 b) {
    return a[0]*b[0] + a[1]*b[1] + a[2]*b[2] + a[3]*b[3] + a[4]*b[4] + a[5]*b[5] + a[6]*b[6] + a[7]*b[7];
}
