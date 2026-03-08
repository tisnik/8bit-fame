#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 1000000

float array[N];

float sum_array() {
    float sum = 0.0f;
    for (int i = 0; i < N; i++) {
        sum += array[i]; // Simple addition
    }
    return sum;
}

int main() {
    // Initialize array with random values (0.0f to 1.0f)
    for (int i = 0; i < N; i++) {
        array[i] = (float)rand() / RAND_MAX;
    }

    // Time the sum
    clock_t start = clock();
    float   result = sum_array();
    clock_t end = clock();

    printf("Sum: %.4f\n", result);
    printf("Time: %.4f ms\n", (double)(end - start) / CLOCKS_PER_SEC * 1000);
    return 0;
}
