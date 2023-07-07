#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#define OK 0
#define ERROR 1

#define EXIT_SUCCESS 0
#define EXIT_FAILURE 1

#define MAX_FILENAME_LENGTH 200

int parse_int_parameter(char *input)
{
    int output;
    char *end;

    errno = 0;
    output = strtol(input, &end, 10);

    /* Check for various possible errors */
    if (errno != 0) {
        perror("strtol");
        exit(EXIT_FAILURE);
    }

    /* Check if at least one digit was found */
    if (input == end) {
        printf("Invalid input value: %s\n", input);
        exit(EXIT_FAILURE);
    }

    return output;
}

unsigned char **allocate_sprite(int bytes_per_line, int height)
{
    int i;

    /* allocate row pointers */
    unsigned char **sprite =
        (unsigned char **) calloc(sizeof(unsigned char *), height);

    /* allocate rows */
    for (i = 0; i < height; i++) {
        sprite[i] =
            (unsigned char *) calloc(sizeof(unsigned char),
                                     bytes_per_line + 1);
    }
    return sprite;

}

/* Read binary file with sprite data: a true bitmap. */
int read_input_sprite_file(int bytes_per_line, int height,
                           char *input_file, unsigned char **sprite)
{
    FILE *fin;
    int i, j;

    fin = fopen(input_file, "rb");
    for (j = 0; j < height; j++) {
        for (i = 0; i < bytes_per_line; i++) {
            int byte = fgetc(fin);
            if (byte == EOF) {
                perror("fgetc");
                fclose(fin);
                return ERROR;
            }
            sprite[j][i] = byte;
        }
        /* last byte on row */
        sprite[j][bytes_per_line] = 0x00;
    }
    fclose(fin);
    return OK;
}

/* Write binary file with sprite data: a true bitmap. */
int write_output_sprite_file(int bytes_per_line, int height,
                             char *output_file, unsigned char **sprite,
                             int shift)
{
    FILE *fout;
    int i, j;

    char filename[MAX_FILENAME_LENGTH];

    snprintf(filename, MAX_FILENAME_LENGTH, "%s_%d.bin", output_file, shift);

    fout = fopen(filename, "wb");
    for (j = 0; j < height; j++) {
        for (i = 0; i < bytes_per_line; i++) {
            int written = fputc(sprite[j][i], fout);
            if (written == EOF) {
                perror("fputc");
                fclose(fout);
                return ERROR;
            }
        }
        /* last byte on row */
        sprite[j][bytes_per_line] = 0;
    }
    fclose(fout);
    return OK;
}

/* Shift sprite right by one pixel. */
void shift_sprite(int bytes_per_line, int height, unsigned char **sprite)
{
    int i, j;
    for (j = 0; j < height; j++) {
        for (i = bytes_per_line-1; i >= 0; i--) {
            unsigned char byte = sprite[j][i];
            byte >>= 1;
            if (i != 0) {
                /* check lowest bit of previous byte */
                if ((sprite[j][i-1] & 0x01) == 0x01) {
                    byte |= 0x80;
                }
            }
            sprite[j][i] = byte;
        }
    }
}

void perform_conversion(int bytes_per_line, int height, char *input_file,
                        char *output_file)
{
    unsigned char **sprite = allocate_sprite(bytes_per_line, height);
    int shift;

    if (read_input_sprite_file(bytes_per_line, height, input_file, sprite)
        != OK) {
        exit(EXIT_FAILURE);
    }

    for (shift = 0; shift < 8; shift++) {
        if (write_output_sprite_file
            (bytes_per_line + 1, height, output_file, sprite,
             shift) != OK) {
            exit(EXIT_FAILURE);
        }
        shift_sprite(bytes_per_line + 1, height, sprite);
    }
}

int main(int argc, char *argv[])
{
    int bytes_per_line;
    int height;

    /* check CLI arguments */
    if (argc != 5) {
        printf("Usage: %s [bytes_per_line] [height] [input.bin] [output]",
               argv[0]);
        exit(EXIT_FAILURE);
    }

    bytes_per_line = parse_int_parameter(argv[1]);
    height = parse_int_parameter(argv[2]);

    printf("Bytes per line: %d\n", bytes_per_line);
    printf("Height:         %d\n", height);

    perform_conversion(bytes_per_line, height, argv[3], argv[4]);

    return EXIT_SUCCESS;
}
