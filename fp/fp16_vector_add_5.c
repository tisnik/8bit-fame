#include <stdio.h>
#include <arm_neon.h>

float16x4_t vector_add(float16x4_t a, float16x4_t b) {
    return vadd_f16(a, b);
}

int main(void) {
    float16x4_t a = {1, 2, 3, 4};
    float16x4_t b = {1, 2, 3, 4};
    float16x4_t c = vector_add(a, b);

    printf("%2.0f, %2.0f, %2.0f, %2.0f\n", c[0], c[1], c[2], c[3]);
}

