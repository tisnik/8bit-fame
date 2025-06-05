#include <stdio.h>

int main(void) {
    unsigned char huge *ptr = (unsigned char*)0xffff;
    printf("%p\n", ptr);
    ptr++;
    printf("%p\n", ptr);
    return 0;
}
