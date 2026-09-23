#include <atari.h>

void wsync(void) {
    unsigned char *clk = 0x14;
    unsigned char old = *clk;

    while (old == *clk) {
    }
}

void main(void) {
    unsigned char x = 128;

    GTIA_WRITE.hposp0 = x;
    OS.pcolr0 = (5 << 4) + 8;
    GTIA_WRITE.grafp0 = 0xFF;
    GTIA_WRITE.gractl = 0;

    while (1) {
        x++;
        GTIA_WRITE.hposp0 = x;
        wsync();
    }
}
