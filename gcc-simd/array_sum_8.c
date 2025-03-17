float array_sum(float *a) {
    #define SIZE 8
    int i;
    float result = 0.0;
    for (i=0; i<SIZE; i++) {
        result += a[i];
    }
    return result;
}
