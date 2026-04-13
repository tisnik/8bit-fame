#include <errno.h>
#include <math.h>
#include <stdio.h>

int main() {
    float x = 1.0;
    float y = x / 0;
    float z = y - y;

    printf("x=%f\n", x);
    printf("y=%f\n", y);
    printf("z=%f\n", z);
    return 0;
}
