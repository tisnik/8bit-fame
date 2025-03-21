void clear(unsigned char *a) {
    #define SIZE 128
    int i;
    for (i=0; i<SIZE; i++) {
        a[i] = 0;
    }
}
