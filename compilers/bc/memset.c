#include <mem.h>

void * memset(void *dest, register int val, register size_t len) {
    register unsigned char *ptr = (unsigned char*)dest;
    while (len-- > 0)
        *ptr++ = val;
    return dest;
}
