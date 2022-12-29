#include "neslib.h"

#define BLACK_COLOR      0x0f
#define DARK_GRAY_COLOR  0x00
#define LIGHT_GRAY_COLOR 0x10
#define WHITE_COLOR      0x30
#define MARIO_BACKGROUND_COLOR 0x22

#pragma bss-name(push, "ZEROPAGE")

const unsigned char palette[] = {
    MARIO_BACKGROUND_COLOR, DARK_GRAY_COLOR, LIGHT_GRAY_COLOR, WHITE_COLOR,
    BLACK_COLOR, BLACK_COLOR, BLACK_COLOR, BLACK_COLOR,
    BLACK_COLOR, BLACK_COLOR, BLACK_COLOR, BLACK_COLOR,
    BLACK_COLOR, BLACK_COLOR, BLACK_COLOR, BLACK_COLOR
};

void game_loop(void)
{
    while (1) {
    }
}

void main(void)
{
    ppu_off();
    pal_bg(palette);
    ppu_on_all();

    game_loop();
}
