#include <stdlib.h>

#include "image.h"



/**
 * Compute the total size in bytes of an image's pixel buffer.
 *
 * @param image Pointer to the image whose buffer size will be computed.
 *
 * @returns Total number of bytes required for the image's pixel buffer
 *          (width * height * bpp).
 */
size_t image_size(const image_t *image) {
    if (image == NULL) {
        return 0;
    }
    /* cast to size_t before multiplication to prevent overflow */
    return (size_t)image->width * (size_t)image->height * (size_t)image->bpp;
}



/**
 * Create an image_t with the given width, height, and bytes-per-pixel,
 * allocating a pixel buffer.
 *
 * The returned image_t fields width, height, and bpp are initialized and
 * pixels points to a newly allocated buffer of size width * height * bpp. If
 * allocation fails, pixels will be NULL.
 *
 * @param width  Image width specified in pixels.
 * @param height Image height specified in pixels.
 * @param bpp    Bytes per pixel (bytes used to store a single pixel).
 *
 * @returns The initialized image_t; its `pixels` member points to the
 *          allocated buffer or NULL on allocation failure.
 */
image_t image_create(const unsigned int width, const unsigned int height, const unsigned int bpp) {
    image_t image;

    /* validate image size */
    if (width == 0 || height == 0 || width > MAX_WIDTH || height > MAX_HEIGHT) {
        image.width = 0;
        image.height = 0;
        image.bpp = 0;
        image.pixels = NULL;
        return image;
    }

    /* validate image type */
    if (bpp != GRAYSCALE && bpp != RGB && bpp != RGBA) {
        image.width = 0;
        image.height = 0;
        image.bpp = 0;
        image.pixels = NULL;
        return image;
    }

    /* initialize image */
    image.width = width;
    image.height = height;
    image.bpp = bpp;

    /* callers must check that image.pixels != NULL */
    image.pixels = (unsigned char *)malloc(image_size(&image));

    /* make sure the image will be 'zero value' when pixels are not allocated */
    if (image.pixels == NULL) {
        image.width = 0;
        image.height = 0;
        image.bpp = 0;
    }
    return image;
}

