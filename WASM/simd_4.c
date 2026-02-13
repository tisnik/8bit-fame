#include <stdio.h>

typedef signed char i8x16 __attribute__((vector_size(16)));

i8x16 add(i8x16 x, i8x16 y) {
    return x + y;
}

void print_vector(i8x16 *v) {
    int i;

    printf("[");
    for (i = 0; i < 16; i++) {
        printf(" %2d", (*v)[i]);
    }
    printf("]\n");
}

int main(void) {
    i8x16 v1 = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
    i8x16 v2 = {10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10};
    i8x16 v3 = v1 + v2;

    print_vector(&v1);
    print_vector(&v2);
    print_vector(&v3);

    return 0;
}
