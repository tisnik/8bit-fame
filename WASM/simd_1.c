#include <stdio.h>

typedef signed char i8x16 __attribute__((vector_size(16)));

int main(void) {
    printf("scalar signed byte:   %ld byte(s)\n", sizeof(signed char));
    printf("vector signed bytes:  %ld byte(s)\n", sizeof(i8x16));
    return 0;
}
