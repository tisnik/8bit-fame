void set_red_component(float *restrict red, float *restrict rgb) {
    #define SIZE 16
    int i;
    for (i=0; i<SIZE/3; i++) {
        rgb[3*i] = red[i];
    }
}

void set_green_component(float *restrict green, float *restrict rgb) {
    #define SIZE 16
    int i;
    for (i=0; i<SIZE/3; i++) {
        rgb[3*i+1] = green[i];
    }
}

void set_blue_component(float *restrict blue, float *restrict rgb) {
    #define SIZE 16
    int i;
    for (i=0; i<SIZE/3; i++) {
        rgb[3*i+2] = blue[i];
    }
}

