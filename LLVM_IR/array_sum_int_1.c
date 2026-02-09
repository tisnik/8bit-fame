unsigned int sum(unsigned int *array, int size) {
    unsigned int s = 0;
    int i;

    for (i=0; i<size; i++) {
        s += array[i];
    }
    return s;
}
