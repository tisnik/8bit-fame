void add_delta(unsigned char *a, unsigned char delta) {
    #define SIZE 16
    int i;
    for (i=0; i<SIZE; i++) {
        a[i] += delta;
    }
}
