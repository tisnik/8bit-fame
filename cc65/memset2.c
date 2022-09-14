#include <stdint.h>

void memset8(uint8_t * dest, uint8_t c, uint8_t n)
{
    register uint8_t i;

    for (i = 0; i < n; i++) {
        dest[i] = c;
    }
}

int main(void)
{
    uint8_t *dest = (uint8_t *) 0x0600;
    uint8_t bytes = 0xff;
    uint8_t fill = 0x00;
    memset8(dest, fill, bytes);

    return 0;
}
