/*
 * Datový typ _complex128 v programovacím jazyku C
 *
 * Realizace tisku hodnot typu _complex128 do řetězce i na terminál.
 */

#include <stdio.h>
#include <quadmath.h>

int main(void) {
#define N 100
    char buffer[N];
    __complex128 z = 1.0q/3.0q + 1.0iq/9.0q;

    quadmath_snprintf(buffer, sizeof buffer, "%.30Qf", crealq(z));
    puts(buffer);
    quadmath_snprintf(buffer, sizeof buffer, "%.30Qf", cimagq(z));
    puts(buffer);

    return 0;
}
