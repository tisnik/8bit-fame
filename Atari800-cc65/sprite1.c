#include <peekpoke.h>

#define HPOSP0 0xD000
#define PCOLR0 0x02C0
#define GRAFP0 0xD00D
#define GRACTL 0xD01D

void main(void) {
    POKE(HPOSP0, 128);
    POKE(PCOLR0, (5 << 4) + 8);
    POKE(GRAFP0, 0xFF);
    POKE(GRACTL, 0);

    while (1) {
    }
}
