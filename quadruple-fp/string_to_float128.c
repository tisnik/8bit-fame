/*
 * Datový typ __float128 v programovacím jazyku C
 *
 * Převod z řetězce na hodnoty typu __float128.
 */

#include <stdio.h>
#include <quadmath.h>

void print_fp128_value(__float128 x) {
#define N 50
    char buffer[N];
    quadmath_snprintf(buffer, sizeof buffer, "%.*Qf", N-5, x);
    puts(buffer);
}

int main(void) {

    __float128 x;

    x = strtoflt128 ("1.0", NULL);
    print_fp128_value(x);

    x = strtoflt128 ("0.1", NULL);
    print_fp128_value(x);

    x = strtoflt128 ("0.00000000000000000000000000000000001", NULL);
    print_fp128_value(x);

    x = strtoflt128 ("0.000000000000000000000000000000000000000000001", NULL);
    print_fp128_value(x);

    x = strtoflt128 ("0.0000000000000000000000000000000000000000000001", NULL);
    print_fp128_value(x);

    return 0;
}
