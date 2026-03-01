/*
 * Datový typ __complex128 v programovacím jazyku C
 *
 * Konverze hodnot typu __complex128 na hodnoty typu __float128.
 */

#include <stdio.h>
#include <quadmath.h>

extern void print_float128(__float128 x) {
#define N 20
    char buffer[N];

    quadmath_snprintf(buffer, sizeof buffer, "%.*Qf", N-10, x);
    puts(buffer);

    putchar('\n');
}

extern void print_complex128(__complex128 x) {
#define N 20
    char buffer[N];

    quadmath_snprintf(buffer, sizeof buffer, "%.*Qf", N-10, crealq(x));
    printf("%s + i", buffer);
    quadmath_snprintf(buffer, sizeof buffer, "%.*Qf", N-10, cimagq(x));
    puts(buffer);

    putchar('\n');
}

int main(int argc, char **argv) {
    __complex128 x = 3.0q + 4.0iq;
    __float128 y;

    puts("x:");
    print_complex128(x);

    puts("crealq:");
    y = crealq(x);
    print_float128(y);

    puts("cimagq:");
    y = cimagq(x);
    print_float128(y);

    puts("cabsq:");
    y = cabsq(x);
    print_float128(y);

    puts("cargq:");
    y = cargq(x);
    print_float128(y);

    return 0;
}
