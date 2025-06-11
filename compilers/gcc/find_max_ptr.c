#include <stdio.h>

typedef unsigned int uint;

uint* find_max_ptr(uint *array, uint length) {
    uint *max_ptr = array;
    uint *item = array;
    uint i;

    for (i=0; i<length; i++) {
        if (*max_ptr < *item) {
            max_ptr = item;
        }
        item++;
    }
    return max_ptr;
}

int main(void) {
    uint *max = NULL;

#define LENGTH_1 10
#define LENGTH_2 10
#define LENGTH_3 1
    uint array_1[LENGTH_1] = {0, 6, 7, 8, 9, 0, 1, 2, 3, 4};
    uint array_2[LENGTH_2] = {9, 8, 7, 6, 5, 4, 3, 2, 1, 0};
    uint array_3[LENGTH_3] = {100};

    max = find_max_ptr(array_1, LENGTH_1);
    printf("%d\n", *max);

    max = find_max_ptr(array_2, LENGTH_2);
    printf("%d\n", *max);

    max = find_max_ptr(array_3, LENGTH_3);
    printf("%d\n", *max);

    return 0;
}

