/*
 * Datový typ __float128 v programovacím jazyku C
 *
 * Základní aritmetické operace s hodnotami typu __float128
 */

#include <stdio.h>
#include <quadmath.h>

extern __float128 add128(__float128 x, __float128 y) {
    return x+y;
}

extern __float128 sub128(__float128 x, __float128 y) {
    return x-y;
}

extern __float128 mul128(__float128 x, __float128 y) {
    return x*y;
}

extern __float128 div128(__float128 x, __float128 y) {
    return x/y;
}

extern void print_float128(__float128 x) {
#define N 100
    char buffer[N];

    quadmath_snprintf(buffer, sizeof buffer, "%.*Qf", N-10, x);
    puts(buffer);
}

int main(int argc, char **argv) {
    __float128 x = 1.0q/3.0q;
    __float128 y = 2.0q/3.0q;
    __float128 z;

    z = add128(x, y);
    print_float128(z);

    z = sub128(x, y);
    print_float128(z);

    z = mul128(x, y);
    print_float128(z);

    z = div128(x, y);
    print_float128(z);

    return 0;
}
