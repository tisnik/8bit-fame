#include <atari.h>

void main(void) {
    GTIA_WRITE.hposp0 = 128;
    OS.pcolr0 = (5 << 4) + 8;
    GTIA_WRITE.grafp0 = 0xFF;
    GTIA_WRITE.gractl = 0;

    while (1) {
    }
}
