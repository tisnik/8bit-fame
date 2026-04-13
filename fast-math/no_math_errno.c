#include <errno.h>
#include <math.h>
#include <stdio.h>

int main() {
    printf("errno code for 'EDOM: Mathematics argument out of domain of function: %d\n", EDOM);

    float x = 2;
    printf("x=%f\terrno: %d\n", x, errno);

    float y = sqrtf(x);
    printf("y=%f\terrno: %d\n", y, errno);

    float z = sqrtf(-x);
    printf("z=%f\terrno: %d\n", z, errno);
    return 0;
}
