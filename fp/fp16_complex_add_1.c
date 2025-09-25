#include <stdio.h>
#include <arm_neon.h>

float16x4_t complex_add_rot90(float16x4_t a, float16x4_t b) {
    return vcadd_rot90_f16(a, b);
}

float16x4_t complex_add_rot270(float16x4_t a, float16x4_t b) {
    return vcadd_rot270_f16(a, b);
}

int main(void) {
    float16x4_t a = {1, 2, 3, 4};
    float16x4_t b = {1, 0, 3, 0};
    float16x4_t c = complex_add_rot90(a, b);

    float16x4_t d = complex_add_rot270(a, b);

    printf("a: %2.0f + %2.0fi   %2.0f + %2.0fi\n", a[0], a[1], a[2], a[3]);
    printf("b: %2.0f + %2.0fi   %2.0f + %2.0fi\n", b[0], b[1], b[2], b[3]);

    printf("c: %2.0f + %2.0fi   %2.0f + %2.0fi\n", c[0], c[1], c[2], c[3]);
    printf("d: %2.0f + %2.0fi   %2.0f + %2.0fi\n", d[0], d[1], d[2], d[3]);
}

