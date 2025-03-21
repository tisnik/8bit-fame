void clear(float *a) {
    #define SIZE 8
    int i;
    for (i=SIZE-1; i>=0; i--) {
        a[i] = 0.0;
    }
}
