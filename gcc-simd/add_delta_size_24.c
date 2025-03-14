void add_delta(float *a, float delta) {
    #define SIZE 24
    int i;
    for (i=0; i<SIZE; i++) {
        a[i] += delta;
    }
}
