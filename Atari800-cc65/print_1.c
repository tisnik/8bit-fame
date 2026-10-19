#include <stdint.h>
#include <peekpoke.h>

void main(void) {
    uint8_t *dest = (uint8_t *)PEEKW(88);
    uint8_t i = 0;

    for (i=0; i<40*5; i++) {
        *dest++ = 33;
    }

    while (1) {
    }
}
