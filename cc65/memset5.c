#include <stdint.h>

void memset8(uint8_t * dest, const uint8_t c, uint8_t n)
{
    /* pozor na hodnotu n=0! */
    do {
        *dest++ = c;
        n--;
    } while (n > 0);
}

int main(void)
{
    uint8_t *dest = (uint8_t *) 0x0600;
    uint8_t bytes = 0xff;
    uint8_t fill = 0x00;
    memset8(dest, fill, bytes);

    return 0;
}
