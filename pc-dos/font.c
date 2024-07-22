#include <stdio.h>

#define INPUT_FILE "font.hex"
#define OUTPUT_FILE "font.bin"
#define CHARACTERS 95
#define CHAR_HEIGHT 16

int main(void) {
    FILE *fin;
    FILE *fout;
    int i;

    fin = fopen(INPUT_FILE, "r");
    fout = fopen(OUTPUT_FILE, "wb");

    for (i = 0; i < CHARACTERS; i++) {
        int c;
        int scanline;

        printf("%d\n", i);

        /* skip to ':' */
        while ((c = fgetc(fin)) != ':') {
            /* read until hits ':' */
        }

        for (scanline = 0; scanline < CHAR_HEIGHT; scanline++) {
            int b;
            fscanf(fin, "%02x", &b);
            fputc(b, fout);
        }

        /* skip endline */
        while ((c = fgetc(fin)) != '\n') {
            /* read until hits ':' */
        }
    }

    fclose(fin);
    fclose(fout);
}
