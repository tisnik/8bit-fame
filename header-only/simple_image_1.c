#include <stdint.h>
#include "stb_image_write.h"

#define WIDTH 4
#define HEIGHT 4
#define RGBA 4

uint32_t image[] = {
    0xff000000, 0xff000000, 0xff000000, 0xff000000,
    0xff000000, 0xff0000ff, 0xff00ff00, 0xff000000,
    0xff000000, 0xff00ffff, 0xffff0000, 0xff000000,
    0xff000000, 0xff000000, 0xff000000, 0xff000000,
};

int main(void) {
    stbi_write_png("test.png", WIDTH, HEIGHT, RGBA, image, WIDTH*sizeof(uint32_t));
    return 0;
}

