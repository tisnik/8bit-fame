float dot_product_4(float *a, float *b) {
#define SIZE 4
    int   i;
    float result = 0.0;
    for (i = 0; i < SIZE; i++) {
        result += a[i] * b[i];
    }
    return result;
}
