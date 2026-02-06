#include <stdio.h>
 
typedef float  f32x4 __attribute__((vector_size(16)));
typedef double f64x2 __attribute__((vector_size(16)));
typedef __fp16 f16x8 __attribute__((vector_size(16)));
 
int main(void)
{
    printf("float:  %ld bytes\n", sizeof(float));
    printf("double: %ld bytes\n", sizeof(double));
    printf("fp16:   %ld bytes\n", sizeof(__fp16));
 
    printf("vector float:  %ld bytes\n", sizeof(f32x4));
    printf("vector double: %ld bytes\n", sizeof(f64x2));
    printf("vector fp16:   %ld bytes\n", sizeof(f16x8));
 
    return 0;
}
