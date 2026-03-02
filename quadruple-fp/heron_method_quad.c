/*
 * Datový typ __float128 v programovacím jazyku C
 *
 * Iterativní výpočet odmocniny: realizace pro hodnoty typu __float128.
 */

#include <stdio.h>
#include <quadmath.h>

int main(void) {
#define N 50
    char buffer[N];

    __float128 s = 2.0q;
    __float128 x = 1.0q;

    int i;

    for (i=0; i<10; i++) {
        quadmath_snprintf(buffer, sizeof buffer, "%.40Qf", x);
        printf("%3d %s\n", i, buffer);
        x = 1.0q/2.0q*(x+s/x);
    }

    return 0;
}
