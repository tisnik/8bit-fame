#include <stdio.h>
#include <arm_neon.h>

float16x8_t complex_add_rot90(float16x8_t a, float16x8_t b) {
    return vcaddq_rot90_f16(a, b);
}

float16x8_t complex_add_rot270(float16x8_t a, float16x8_t b) {
    return vcaddq_rot270_f16(a, b);
}

int main(void) {
    float16x8_t a = {1, 2, 3, 4, 1, 2, 3, 4};
    float16x8_t b = {1, 0, 3, 0, 0, 1, 0, 1};
    float16x8_t c = complex_add_rot90(a, b);

    float16x8_t d = complex_add_rot270(a, b);

    printf("a: %2.0f + %2.0fi   %2.0f + %2.0fi   ", a[0], a[1], a[2], a[3]);
    printf("%2.0f + %2.0fi   %2.0f + %2.0fi\n", a[4], a[5], a[6], a[7]);
    printf("b: %2.0f + %2.0fi   %2.0f + %2.0fi   ", b[0], b[1], b[2], b[3]);
    printf("%2.0f + %2.0fi   %2.0f + %2.0fi\n", b[4], b[5], b[6], b[7]);

    printf("c: %2.0f + %2.0fi   %2.0f + %2.0fi   ", c[0], c[1], c[2], c[3]);
    printf("%2.0f + %2.0fi   %2.0f + %2.0fi\n", c[4], c[5], c[6], c[7]);
    printf("d: %2.0f + %2.0fi   %2.0f + %2.0fi   ", d[0], d[1], d[2], d[3]);
    printf("%2.0f + %2.0fi   %2.0f + %2.0fi\n", d[4], d[5], d[6], d[7]);
}

