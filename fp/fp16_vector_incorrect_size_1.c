#include <stdio.h>
 
typedef _Float16 float16x8 __attribute__((vector_size(17)));

int main(void)
{
    printf("scalar: %ld bytes\n", sizeof(_Float16));
    printf("vector: %ld bytes\n", sizeof(float16x8));
 
    return 0;
}
