/*
 * Datový typ __float128 v programovacím jazyku C
 *
 * Volání funkce definované v hlavičkovém souboru quadmath.h
 */

#include <stdio.h>
#include <math.h>
#include <quadmath.h>

int main(void) {
#define N 100
    char buffer[N];
    
    _Float16 x16 = sqrtf(2.0f);
    float x32 = sqrtf(2.0f);
    double x64 = sqrt(2.0);
    __float128 x128 = sqrtq(2.0q);

    printf("%.*f\n", N-10, (double)x16);
    printf("%.*f\n", N-10, x32);
    printf("%.*f\n", N-10, x64);
    quadmath_snprintf(buffer, sizeof buffer, "%.*Qf", N-10, x128);
    puts(buffer);

    return 0;
}
