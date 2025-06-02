#include <stdio.h>

int main(void) {
#define LENGTH 100000
    long i;
    unsigned char far *array = (unsigned char far*)farmalloc(LENGTH);
    printf("%p\n", array);
    for (i=0; i<LENGTH; i++) {
        array[i] = 0;
    }
    return 0;
}
