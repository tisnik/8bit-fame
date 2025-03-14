#include <math.h>

void array_sqrt(float *a) {
    #define SIZE 24
    int i;
    for (i=0; i<SIZE; i++) {
        a[i] = sqrt(a[i]);
    }
}
