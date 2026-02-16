void get_red_component(float *restrict red, float *restrict rgb) {
#define SIZE 16
    int i;
    for (i = 0; i < SIZE / 3; i++) {
        red[i] = rgb[3 * i];
    }
}

void get_green_component(float *restrict green, float *restrict rgb) {
#define SIZE 16
    int i;
    for (i = 0; i < SIZE / 3; i++) {
        green[i] = rgb[3 * i + 1];
    }
}

void get_blue_component(float *restrict blue, float *restrict rgb) {
#define SIZE 16
    int i;
    for (i = 0; i < SIZE / 3; i++) {
        blue[i] = rgb[3 * i + 2];
    }
}
