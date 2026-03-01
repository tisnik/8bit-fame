/*
 * Datový typ __complex128 v programovacím jazyku C
 *
 * Základní aritmetické operace s hodnotami typu __complex128
 */

#include <stdio.h>
#include <quadmath.h>

extern __complex128 add128(__complex128 x, __complex128 y) {
    return x+y;
}

extern __complex128 sub128(__complex128 x, __complex128 y) {
    return x-y;
}

extern __complex128 mul128(__complex128 x, __complex128 y) {
    return x*y;
}

extern __complex128 div128(__complex128 x, __complex128 y) {
    return x/y;
}

extern void print_complex128(__complex128 x) {
#define N 100
    char buffer[N];

    quadmath_snprintf(buffer, sizeof buffer, "%.*Qf", N-10, crealq(x));
    puts(buffer);
    quadmath_snprintf(buffer, sizeof buffer, "%.*Qf", N-10, cimagq(x));
    puts(buffer);

    putchar('\n');
}

int main(int argc, char **argv) {
    __complex128 x = 1.0q/3.0q + 0.5iq;
    __complex128 y = 2.0q/3.0q + 0.25iq;
    __complex128 z;

    puts("x:");
    print_complex128(x);

    puts("y:");
    print_complex128(y);

    z = add128(x, y);
    puts("x+y:");
    print_complex128(z);

    z = sub128(x, y);
    puts("x-y:");
    print_complex128(z);

    z = mul128(x, y);
    puts("x*y:");
    print_complex128(z);

    z = div128(x, y);
    puts("x/y:");
    print_complex128(z);

    return 0;
}
