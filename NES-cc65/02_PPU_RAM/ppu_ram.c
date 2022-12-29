#include "neslib.h"

#define BLACK_COLOR      0x0f
#define DARK_GRAY_COLOR  0x00
#define LIGHT_GRAY_COLOR 0x10
#define WHITE_COLOR      0x30
#define MARIO_BACKGROUND_COLOR 0x22

#pragma bss-name(push, "ZEROPAGE")
int i;

const unsigned char palette[] = {
    MARIO_BACKGROUND_COLOR, DARK_GRAY_COLOR, LIGHT_GRAY_COLOR, WHITE_COLOR,
    BLACK_COLOR, BLACK_COLOR, BLACK_COLOR, BLACK_COLOR,
    BLACK_COLOR, BLACK_COLOR, BLACK_COLOR, BLACK_COLOR,
    BLACK_COLOR, BLACK_COLOR, BLACK_COLOR, BLACK_COLOR
};

void fill_in_ppu_ram(void)
{
    vram_adr(NTADR_A(0, 0));
    for (i = 0; i < 32 * 30; i++) {
        vram_put(i);
    }
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
    ppu_on_all();

    game_loop();
}
