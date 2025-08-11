#include <stdio.h>
#include <stdint.h>

uint32_t lfsr_rand(void)
{
    uint16_t start_state = 0xACE1u;
    uint16_t lfsr = start_state;
    uint16_t bit;
    uint32_t period = 0;

    do {
        bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5)) & 1u;
        lfsr = (lfsr >> 1) | (bit << 15);
        ++period;
    } while (lfsr != start_state);

    return period;
}

int main(void) {
    FILE *fout;

    uint32_t random_value;
    int i;

    fout = fopen("random.bin", "wb");
    if (fout == NULL) {
        perror("fopen");
        return 1;
    }

    for (i=0; i<1000000; i++) {
        random_value = lfsr_rand();
        fwrite(&random_value, sizeof(uint32_t), 1, fout);
        if (ferror(fout)) {
            perror("fwrite");
            return 1;
        }
    }

    fclose(fout);

    return 0;
}

