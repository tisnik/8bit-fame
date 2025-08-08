#include <limits.h>
#include <stdio.h>

void add_with_carry(unsigned int x, unsigned int y, unsigned int carry_in) {
    unsigned int carry_out;
    unsigned int result;

    result = __builtin_addc(x, y, carry_in, &carry_out);
    printf("%u + %u + %u = (%u)%u\n", x, y, carry_in, carry_out, result);
}

void sub_with_carry(unsigned int x, unsigned int y, unsigned int carry_in) {
    unsigned int carry_out;
    unsigned int result;

    result = __builtin_subc(x, y, carry_in, &carry_out);
    printf("%u - %u - %u = (%u)%u\n", x, y, carry_in, carry_out, result);
}

int main(void) {
    add_with_carry(0, 0, 0);
    add_with_carry(0, 0, 1);
    add_with_carry(1, 2, 0);
    add_with_carry(1, 2, 1);

    add_with_carry(UINT_MAX, 0, 0);
    add_with_carry(UINT_MAX, 0, 1);
    add_with_carry(UINT_MAX, 1, 0);
    add_with_carry(UINT_MAX, 1, 1);

    putchar('\n');

    sub_with_carry(0, 0, 0);
    sub_with_carry(0, 0, 1);
    sub_with_carry(2, 1, 0);
    sub_with_carry(2, 1, 1);
    sub_with_carry(2, 2, 0);
    sub_with_carry(2, 2, 1);
}

