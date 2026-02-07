#ifndef _IMAGE_H_
#define _IMAGE_H_

/* Image types */
#define GRAYSCALE 1
#define RGB 3
#define RGBA 4

/* Maximum image resolution */
#define MAX_WIDTH 8192
#define MAX_HEIGHT 8192

/**
 * Structure that represents raster image of configurable resolution and bits
 * per pixel format.
 */
typedef struct {
    unsigned int   width;
    unsigned int   height;
    unsigned int   bpp;
    unsigned char *pixels;
} image_t;

enum error {
    OK,
    NULL_POINTER,
    NULL_IMAGE_POINTER,
    NULL_PIXELS_POINTER,
    INVALID_IMAGE_DIMENSION,
    INVALID_IMAGE_TYPE
};

/* function headers */
size_t image_size(const image_t *image);
image_t image_create(const unsigned int width, const unsigned int height, const unsigned int bpp);

#endif

