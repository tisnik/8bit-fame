void add_delta(double *a, double delta) {
#define SIZE 4
    int i;
    for (i = 0; i < SIZE; i++) {
        a[i] += delta;
    }
}
