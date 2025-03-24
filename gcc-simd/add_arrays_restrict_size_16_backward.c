void add_arrays(float *restrict a, float *restrict b) {
    #define SIZE 16
    int i;
    for (i=SIZE-1; i>=0; i--) {
        a[i] += b[i];
    }
}
