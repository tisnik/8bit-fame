void add_arrays(float *a, float *b) {
#define SIZE 16
    int i;
    for (i = SIZE - 1; i >= 0; i--) {
        a[i] += b[i];
    }
}
