#include <stdint.h>
#include <stdio.h>

uint8_t bsf_8bit(uint8_t x) {
    uint8_t z;
    z = __builtin_stdc_first_trailing_one(x);
    return z;
}

void print_bin(uint8_t x) {
    int i;

    for (i = 7; i >= 0; i--) {
        printf("%d", (x >> i) & 1);
    }
}

void test_bsf(uint8_t x) {
    printf("%u \t", x);
    print_bin(x);
    printf("\t%d\n", bsf_8bit(x));
}

int main(void) {
    uint8_t i;

    for (i = 0; i <= 17; i++) {
        test_bsf(i);
    }

    test_bsf(0xff);
}
