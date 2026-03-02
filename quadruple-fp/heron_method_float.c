/*
 * Datový typ __float128 v programovacím jazyku C
 *
 * Iterativní výpočet odmocniny: realizace pro hodnoty typu float.
 */

#include <stdio.h>

int main(void) {
    float s = 2.0f;
    float x = 1.0f;
    int i;

    for (i=0; i<10; i++) {
        printf("%3d  %.40f\n", i, x);
        x = 1.0f/2.0f*(x+s/x);
    }

    return 0;
}
