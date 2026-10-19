#include <stdint.h>
#include <peekpoke.h>

void main(void) {
    uint16_t scr = PEEKW(88);
    register uint8_t i = 0;

    for (i=0; i<40*5; i++) {
        POKE(scr, 33);
        scr++;
    }

    while (1) {
    }
}
