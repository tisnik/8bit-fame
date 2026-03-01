/*
 * Datový typ __complex128 v programovacím jazyku C
 *
 * Volání funkcí akceptujících i vracejících hodnoty typu __complex128.
 */

#include <stdio.h>
#include <quadmath.h>

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
    __complex128 x = 2.0q + 0.0iq;
    __complex128 y = -2.0q + 0.0iq;
    __complex128 z = 0.0q + 2.0iq;
    __complex128 w;

    puts("x:");
    print_complex128(x);

    puts("y:");
    print_complex128(y);

    puts("z:");
    print_complex128(z);

    w = csqrtq(x);
    puts("√x:");
    print_complex128(w);

    w = csqrtq(y);
    puts("√y:");
    print_complex128(w);

    w = csqrtq(z);
    puts("√z:");
    print_complex128(w);

    return 0;
}
