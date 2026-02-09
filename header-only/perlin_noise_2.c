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
            int r = (int)(300.0*stb_perlin_turbulence_noise3(x/200., y/200., 0, 2.2, 0.5, 6));
            if (r>255) r=255;
            int g = (int)(300.0*stb_perlin_turbulence_noise3(x/200., y/200., 0, 1.9, 0.5, 7));
            if (g>255) g=255;
            int b = (int)(300.0*stb_perlin_turbulence_noise3(x/200., y/200., 0, 2.1, 0.5, 8));
            if (b>255) b=255;
            uint32_t color = (0xff << 24) + (r << 16) + (g << 8) + b;
            image[y][x] = color;
        }
    }
    stbi_write_png("perlin.png", WIDTH, HEIGHT, RGBA, image, WIDTH*sizeof(uint32_t));
    return 0;
}

