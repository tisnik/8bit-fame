void add_delta(float *a, float *b) {
#define SIZE 17
    int i;
    for (i = 0; i < SIZE; i++) {
        a[i] += b[i];
    }
}
