#include <stdio.h>

#define PIXELS 320*200

int main(void) {
    FILE *fin;
    FILE *fout;
    int i;

    fin = fopen("1.bmp", "r");
    fseek(fin, 1162, SEEK_SET);

    fout = fopen("image.bin", "w");

    for (i=0; i<PIXELS/4; i++) {
        unsigned char pixels[4];
        unsigned int out;
        fread(pixels, 4, 1, fin);

        out = pixels[3] & 0x03 |
              ((pixels[2] & 0x03) << 2) |
              ((pixels[1] & 0x03) << 4) |
              ((pixels[0] & 0x03) << 6);
        printf("%x ", out);
        fputc(out, fout);
    }

    fclose(fin);
    fclose(fout);
}
