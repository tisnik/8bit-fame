#include <stdint.h>
#include <peekpoke.h>

void main(void) {
    uint8_t *dest = (uint8_t *)PEEKW(88);
    uint8_t i = 0;

    do {
        *dest++ = i;
    } while (i++ != 255);

    while (1) {
    }
}
