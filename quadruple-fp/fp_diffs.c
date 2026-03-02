/*
 * Datový typ __float128 v programovacím jazyku C
 *
 * Rozdílné výsledky operací s hodnotami s plovoucí řádovou čárkou.
 */

#include <stdio.h>
#include <quadmath.h>

int main(void) {
#define N 100
    char buffer[N];
    _Float16 x16 = 1.0/3.0;
    float x32 = 1.0/3.0;
    double x64 = 1.0/3.0;
    __float128 x128 = 1.0q/3.0q;

    printf("%.*f\n", N-10, (double)x16);
    printf("%.*f\n", N-10, x32);
    printf("%.*f\n", N-10, x64);
    quadmath_snprintf(buffer, sizeof buffer, "%.*Qf", N-10, x128);
    puts(buffer);

    return 0;
}
