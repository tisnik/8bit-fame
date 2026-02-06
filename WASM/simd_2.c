#include <stdio.h>
 
typedef signed   char      i8x16 __attribute__((vector_size(16)));
typedef unsigned char      u8x16 __attribute__((vector_size(16)));
typedef signed   short int i16x8 __attribute__((vector_size(16)));
typedef unsigned short int u16x8 __attribute__((vector_size(16)));
typedef signed   int       i32x4 __attribute__((vector_size(16)));
typedef unsigned int       u32x4 __attribute__((vector_size(16)));
typedef   signed long int  i64x2 __attribute__((vector_size(16)));
typedef unsigned long int  u64x2 __attribute__((vector_size(16)));
 
int main(void)
{
    printf("signed char:    %ld bytes\n", sizeof(signed char));
    printf("unsigned char:  %ld bytes\n", sizeof(unsigned char));
    printf("signed short:   %ld bytes\n", sizeof(signed short int));
    printf("unsigned short: %ld bytes\n", sizeof(unsigned short int));
    printf("signed int:     %ld bytes\n", sizeof(signed int));
    printf("unsigned int:   %ld bytes\n", sizeof(unsigned int));
    printf("signed long:    %ld bytes\n", sizeof(signed long int));
    printf("unsigned long:  %ld bytes\n", sizeof(unsigned long int));
 
    printf("\n");

    printf("vector signed char:    %ld bytes\n", sizeof(i8x16));
    printf("vector unsigned char:  %ld bytes\n", sizeof(u8x16));
    printf("vector signed short:   %ld bytes\n", sizeof(i16x8));
    printf("vector unsigned short: %ld bytes\n", sizeof(u16x8));
    printf("vector signed int:     %ld bytes\n", sizeof(i32x4));
    printf("vector unsigned int:   %ld bytes\n", sizeof(u32x4));
    printf("vector signed long:    %ld bytes\n", sizeof(i64x2));
    printf("vector unsigned long:  %ld bytes\n", sizeof(u64x2));
 
    return 0;
}
