#include <stdio.h>

typedef unsigned int uint;

uint find_max(uint *array, uint length) {
    uint max = 0;
    uint i;
    uint *item = array;

    for (i=0; i<length; i++) {
        if (max < *item) {
            max = *item;
        }
        item++;
    }
    return max;
}

int main(void) {
#define LENGTH 10

    uint array[LENGTH] = {5, 6, 7, 8, 9, 0, 1, 2, 3, 4};
    uint max = find_max(array, LENGTH);
    printf("%d\n", max);
    return 0;
}

