/*
 * Datový typ __float128 v programovacím jazyku C
 *
 * Konstanty definované v hlavičkových souborech math.h a quadmath.h
 */

#include <stdio.h>
#include <math.h>
#include <quadmath.h>

int main(void) {
#define N 100
    char buffer[N];
    
    _Float16 x16 = M_SQRT2;
    float x32 = M_SQRT2;
    double x64 = M_SQRT2;
    __float128 x128 = M_SQRT2q;

    printf("%.*f\n", N-10, (double)x16);
    printf("%.*f\n", N-10, x32);
    printf("%.*f\n", N-10, x64);
    quadmath_snprintf(buffer, sizeof buffer, "%.*Qf", N-10, x128);
    puts(buffer);

    return 0;
}
