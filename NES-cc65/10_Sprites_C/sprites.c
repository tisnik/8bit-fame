#include "neslib.h"

#define ATTRIBUTE_TABLE 0x23c0

#pragma bss-name(push, "ZEROPAGE")
int i;
int address;

// barvy pozadí
const unsigned char background_palette[] = {
    0x22, 0x29, 0x1a, 0x0F, 0x22, 0x36, 0x17, 0x0F,
    0x22, 0x30, 0x21, 0x0F, 0x22, 0x27, 0x17, 0x0F
};

// barvy spritů
const unsigned char sprite_palette[] = {
    0x22, 0x16, 0x27, 0x18, 0x22, 0x1A, 0x30, 0x27,
    0x22, 0x16, 0x30, 0x27, 0x22, 0x0F, 0x36, 0x17
};

// definice prvního metaspritu
const unsigned char metasprite1[] = {
    10, 10, 0, 3,
    18, 10, 1, 3,
    10, 18, 2, 3,
    18, 18, 3, 3,
    10, 20, 4, 3,
    18, 20, 5, 3,
    10, 28, 6, 3,
    18, 28, 7, 3,
    128,
};

// definice druhého metaspritu
const unsigned char metasprite2[] = {
    18, 10, 8, 3 | OAM_FLIP_H,
    10, 10, 9, 3 | OAM_FLIP_H,
    18, 18, 10, 3 | OAM_FLIP_H,
    10, 18, 11, 3 | OAM_FLIP_H,
    18, 20, 12, 3 | OAM_FLIP_H,
    10, 20, 13, 3 | OAM_FLIP_H,
    18, 28, 14, 3 | OAM_FLIP_H,
    10, 28, 15, 3 | OAM_FLIP_H,
    128,
};

void fill_in_ppu_ram(void)
{
    vram_adr(NTADR_A(0, 0));
    for (i = 0; i < 32 * 30; i++) {
        vram_put(36);
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
        ppu_wait_nmi();
        oam_clear();
        oam_meta_spr(10, 10, metasprite1);
        oam_meta_spr(40, 10, metasprite2);
    }
}

void main(void)
{
    ppu_off();
    pal_bg(background_palette);
    pal_spr(sprite_palette);
    bank_bg(1);
    bank_spr(0);
    fill_in_ppu_ram();
    fill_in_attributes();
    ppu_on_all();

    game_loop();
}