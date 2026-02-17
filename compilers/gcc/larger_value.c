#include <stdio.h>

typedef unsigned int uint;

uint *larger_value(uint *x, uint *y) {
    if (*x > *y) {
        return x;
    } else {
        return y;
    }
}

int main(void) {
    uint a = 1;
    uint b = 2;

    printf("%d\n", *larger_value(&a, &b));
    printf("%d\n", *larger_value(&b, &a));

    return 0;
}
