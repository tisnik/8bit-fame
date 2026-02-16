#include <float.h>

float find_max_100(float *a) {
#define SIZE 100
    int   i;
    float max = FLT_MIN_EXP;
    for (i = 0; i < SIZE; i++) {
        if (a[i] > max) {
            max = a[i];
        }
    }
    return max;
}
