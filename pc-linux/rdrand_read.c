#include <stdio.h>

int main(void) {
    int success;
    unsigned int random_value;
    int i;

    for (i=0; i<10; i++) {
        success = __builtin_ia32_rdrand32_step(&random_value);
        printf("%d %x\n", success, random_value);
    }
    return 1;
}

