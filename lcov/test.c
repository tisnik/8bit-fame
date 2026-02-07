#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include "image.h"

#define TEST_BEGIN \
    puts(__FUNCTION__); \
    {

#define TEST_END \
    }

void test_image_create_zero_width(void) {
    TEST_BEGIN
    image_t image = image_create(0, 100, 4);
    assert(image.width == 0);
    assert(image.height == 0);
    assert(image.bpp == 0);
    assert(image.pixels == NULL);
    TEST_END
}

void test_image_create_too_wide(void) {
    TEST_BEGIN
    image_t image = image_create(MAX_WIDTH+1, 100, 4);
    assert(image.width == 0);
    assert(image.height == 0);
    assert(image.bpp == 0);
    assert(image.pixels == NULL);
    TEST_END
}

void test_image_create_zero_height(void) {
    TEST_BEGIN
    image_t image = image_create(100, 0, 4);
    assert(image.width == 0);
    assert(image.height == 0);
    assert(image.bpp == 0);
    assert(image.pixels == NULL);
    TEST_END
}

void test_image_create_wrong_image_type(void) {
    TEST_BEGIN
    image_t image = image_create(100, 100, 0);
    assert(image.width == 0);
    assert(image.height == 0);
    assert(image.bpp == 0);
    assert(image.pixels == NULL);
    TEST_END
}

void test_image_create_grayscale(void) {
    TEST_BEGIN
    image_t image = image_create(100, 100, GRAYSCALE);
    assert(image.pixels != NULL);
    free(image.pixels);
    TEST_END
}

void test_image_create_rgba(void) {
    TEST_BEGIN
    image_t image = image_create(100, 100, RGBA);
    assert(image.pixels != NULL);
    free(image.pixels);
    TEST_END
}

int main(void) {
    test_image_create_zero_width();
    test_image_create_too_wide();
    test_image_create_zero_height();
    test_image_create_wrong_image_type();
    test_image_create_grayscale();
    test_image_create_rgba();
    return 0;
}

