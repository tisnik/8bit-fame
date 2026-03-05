#include <stdio.h>
#include <math.h>
#include <time.h>

#define N 1000000

int main() {
    float result = 0.0f;
    clock_t start = clock();

    for (int i = 0; i < N; i++) {
        result += sinf(M_PI*2.0*i/N);
    }

    clock_t end = clock();

    printf("Sum:  %.4f\n", result);
    printf("Time: %.4f ms\n", (double)(end - start) / CLOCKS_PER_SEC * 1000);
    return 0;
}
