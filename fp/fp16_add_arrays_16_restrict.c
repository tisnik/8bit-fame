#define SIZE 16

void add_arrays(_Float16 * restrict a, _Float16 * restrict b) {
    int i;
    for (i=0; i<SIZE; i++) {
        a[i] += b[i];
    }
}
