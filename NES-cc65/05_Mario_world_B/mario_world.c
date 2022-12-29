#include "neslib.h"

#define ATTRIBUTE_TABLE 0x23c0

#pragma bss-name(push, "ZEROPAGE")
int i;
int address;

const unsigned char palette[32] = {
    0x22, 0x29, 0x1a, 0x0F, 0x22, 0x36, 0x17, 0x0F, 0x22, 0x30, 0x21, 0x0F, 0x22, 0x27, 0x17, 0x0F,  // barvy pozadí
    0x22, 0x16, 0x27, 0x18, 0x22, 0x1A, 0x30, 0x27, 0x22, 0x16, 0x30, 0x27, 0x22, 0x0F, 0x36, 0x17,  // barvy spritů
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
    bank_bg(1);
    fill_in_ppu_ram();
    fill_in_attributes();
    ppu_on_all();

    game_loop();
}
