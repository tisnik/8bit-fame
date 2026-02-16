#include <float.h>

float find_max_4(float *a) {
#define SIZE 4
    int   i;
    float max = FLT_MIN_EXP;
    for (i = 0; i < SIZE; i++) {
        if (a[i] > max) {
            max = a[i];
        }
    }
    return max;
}
