/*
 * Datový typ _float128 v programovacím jazyku C
 *
 * Realizace tisku hodnot typu _float128 do řetězce i na terminál.
 */

#include <stdio.h>
#include <quadmath.h>

int main(void) {
#define N 100
    char buffer[N];
    __float128 x = 1.0/3.0;

    quadmath_snprintf(buffer, sizeof buffer, "%.30Qf", x);
    puts(buffer);

    return 0;
}
