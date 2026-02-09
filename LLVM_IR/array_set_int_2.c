void set(unsigned int *array, int size, unsigned int value) {
    unsigned int *p = array;
    int i;

    for (i=0; i<size; i++) {
        *p++=value;
    }
}
