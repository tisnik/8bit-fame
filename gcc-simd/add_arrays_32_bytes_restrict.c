void add_arrays(unsigned char *restrict a, unsigned char *restrict b) {
    #define SIZE 32
    int i;
    for (i=0; i<SIZE; i++) {
        a[i] += b[i];
    }
}
