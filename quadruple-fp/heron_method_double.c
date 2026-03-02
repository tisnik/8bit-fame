/*
 * Datový typ __float128 v programovacím jazyku C
 *
 * Iterativní výpočet odmocniny: realizace pro hodnoty typu double.
 */

#include <stdio.h>

int main(void) {
    double s = 2.0;
    double x = 1.0;
    int i;

    for (i=0; i<10; i++) {
        printf("%3d  %.40f\n", i, x);
        x = 1.0/2.0*(x+s/x);
    }

    return 0;
}
