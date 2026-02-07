#include <stdio.h>
#include <stdint.h>

uint8_t bit_ceil_8bit(uint8_t x) {
    uint8_t z;
    z = __builtin_stdc_bit_ceil(x);
    return z;
}

void print_bin(uint8_t x) {
    int i;

    for (i = 7; i >= 0; i--) {
        printf("%d", (x >> i) & 1);
    }
}

void test_bit_ceil(uint8_t x) {
    printf("%u \t", x);
    print_bin(x);
    printf("\t%d\n", bit_ceil_8bit(x));
}

int main(void) {
    uint8_t i;

    for (i=0; i<=17; i++) {
        test_bit_ceil(i);
    }

    test_bit_ceil(0xff);
}
