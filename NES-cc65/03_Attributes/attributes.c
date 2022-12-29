#include "neslib.h"

#define ATTRIBUTE_TABLE 0x23c0

#pragma bss-name(push, "ZEROPAGE")
int i;
int address;

const unsigned char palette[16] = {
    0x0f, 0x00, 0x10, 0x30,
    0x0f, 0x01, 0x21, 0x31,
    0x0f, 0x06, 0x26, 0x36,
    0x0f, 0x09, 0x29, 0x39
};

void fill_in_ppu_ram(void)
{
    vram_adr(NTADR_A(0, 0));
    for (i = 0; i < 32 * 30; i++) {
        vram_put(i);
    }
}

void fill_in_attributes(void)
{
    vram_adr(ATTRIBUTE_TABLE);

    vram_fill(0, 16);
    vram_fill(0x55, 16);
    vram_fill(0xAA, 16);
    vram_fill(0xFF, 16);
}

void game_loop(void)
{
    while (1) {
    }
}

void main(void)
{
    ppu_off();
    pal_bg(palette);
    fill_in_ppu_ram();
    fill_in_attributes();
    ppu_on_all();

    game_loop();
}
