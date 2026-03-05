#include <stdio.h>

extern long double addLong(long double x, long double y) {
    return x+y;
}

extern long double subLong(long double x, long double y) {
    return x-y;
}

extern long double mulLong(long double x, long double y) {
    return x*y;
}

extern long double divLong(long double x, long double y) {
    return x/y;
}
int main(void) {
    printf("%ld\n", sizeof(long double));
    return 0;
}
