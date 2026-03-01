/*
 * Datový typ __float128 v programovacím jazyku C
 *
 * Speciální hodnoty typu __float128.
 */

#include <stdio.h>
#include <quadmath.h>

extern void print_float128(__float128 x) {
#define N 100
    char buffer[N];

    quadmath_snprintf(buffer, sizeof buffer, "%.*Qf", N-10, x);
    puts(buffer);
}

int main(int argc, char **argv) {
    __float128 x = 1.0q;
    __float128 y = 0.0q;
    __float128 z;
    __float128 w;

    z = x / y;
    print_float128(z);

    z = -x / y;
    print_float128(z);

    w = x/y + x/y;
    print_float128(w);

    w = x/y - x/y;
    print_float128(w);

    w = y/y;
    print_float128(w);

    w = w/w;
    print_float128(w);

    w = sqrtq(-2.0);
    print_float128(w);

    return 0;
}
