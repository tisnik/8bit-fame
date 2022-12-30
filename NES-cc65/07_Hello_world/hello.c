#include "neslib.h"

#pragma bss-name(push, "ZEROPAGE")

unsigned char i;

const unsigned char text[] = "Hello World!";

const unsigned char palette[] = {
    0x22, 0x29, 0x1a, 0x0F, 0x22, 0x36, 0x17, 0x0F, 0x22, 0x30, 0x21, 0x0F, 0x22, 0x27, 0x17, 0x0F,     // barvy pozadí
    0x22, 0x16, 0x27, 0x18, 0x22, 0x1A, 0x30, 0x27, 0x22, 0x16, 0x30, 0x27, 0x22, 0x0F, 0x36, 0x17,     // barvy spritů
};

void game_loop(void)
{
    while (1) {
    }
}

void print_on_screen(void)
{
    vram_adr(NTADR_A(10, 14));

    i = 0;
    while (text[i]) {
        vram_put(text[i]);
        i++;
    }
}

void main(void)
{
    ppu_off();
    pal_bg(palette);
    bank_bg(0);
    print_on_screen();
    ppu_on_all();

    game_loop();
}
