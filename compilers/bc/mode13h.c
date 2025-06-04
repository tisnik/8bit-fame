#include <dos.h>
#include <stdio.h>

int main(void) {
    unsigned char far *ptr = (unsigned char*)MK_FP(0xa000, 0000);
    unsigned int i;
    printf("%p\n", ptr);
    getch();

    asm {
        mov ah, 00h
        mov al, 13h
        int 10h
    }

    for (i=0; i<(unsigned)(320*200); i++) {
        *ptr++ = i;
    }
    getch();
    return 0;
}
