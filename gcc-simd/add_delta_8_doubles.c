void add_delta(double *a, double delta) {
#define SIZE 8
    int i;
    for (i = 0; i < SIZE; i++) {
        a[i] += delta;
    }
}
