void add_delta(float *restrict a, float *restrict b) {
#define SIZE 4
    int i;
    for (i = 0; i < SIZE; i++) {
        a[i] += b[i];
    }
}
