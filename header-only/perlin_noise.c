#include <stdio.h>
#include <stdint.h>

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"

#define STB_PERLIN_IMPLEMENTATION
#include "stb_perlin.h"

#define WIDTH 512
#define HEIGHT 512
#define RGBA 4

uint32_t image[HEIGHT][WIDTH] = {0};

int main(void) {
    int x, y;
    for (y=0; y<HEIGHT; y++) {
        for (x=0; x<WIDTH; x++) {
            int i = (int)(250.0*stb_perlin_turbulence_noise3(x/50., y/50., 0, 2.1, 0.5, 6));
            if (i>255) i=255;
            uint32_t color = (0xff << 24) + (i << 16) + (i << 8) + i;
            image[y][x] = color;
        }
    }
    stbi_write_png("perlin.png", WIDTH, HEIGHT, RGBA, image, WIDTH*sizeof(uint32_t));
    return 0;
}

