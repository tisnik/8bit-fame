void add_arrays(unsigned char *a, unsigned char *b) {
    #define SIZE 32
    int i;
    for (i=0; i<SIZE; i++) {
        a[i] += b[i];
    }
}
