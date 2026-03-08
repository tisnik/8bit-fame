#include <stdio.h>
#include <time.h>

#define N 100000

float array[N];

float sum_array() {
    float sum = 0.0f;
    for (int i = 0; i < N; i++) {
        sum += array[i];
    }
    return sum;
}

int main() {
    for (int i = 0; i < N; i++) {
        array[i] = i % 2 ? i : -i;
    }

    clock_t start = clock();
    float   result = sum_array();
    clock_t end = clock();

    printf("Sum: %.4f\n", result);
    printf("Time: %.4f ms\n", (double)(end - start) / CLOCKS_PER_SEC * 1000);
    return 0;
}
