#include <stdint.h>
#include <stdio.h>

uint8_t bit_width_8bit(uint8_t x) {
    uint8_t z;
    z = __builtin_stdc_bit_width(x);
    return z;
}

void print_bin(uint8_t x) {
    int i;

    for (i = 7; i >= 0; i--) {
        printf("%d", (x >> i) & 1);
    }
}

void test_bit_width(uint8_t x) {
    printf("%u \t", x);
    print_bin(x);
    printf("\t%d\n", bit_width_8bit(x));
}

int main(void) {
    uint8_t i;

    for (i = 0; i <= 17; i++) {
        test_bit_width(i);
    }

    test_bit_width(0xff);
}
