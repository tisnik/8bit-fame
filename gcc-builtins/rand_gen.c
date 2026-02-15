#include <stdint.h>
#include <stdio.h>

uint32_t xorshift32(void) {
    const uint32_t  start_state = 0xACE1u;
    static uint32_t state = start_state;

    uint32_t x = state;
    x ^= x << 13;
    x ^= x >> 17;
    x ^= x << 5;
    return state = x;
}

int main(void) {
    FILE *fout;

    uint32_t random_value;
    int      i;

    fout = fopen("random.bin", "wb");
    if (fout == NULL) {
        perror("fopen");
        return 1;
    }

    for (i = 0; i < 1000000; i++) {
        random_value = xorshift32();
        fwrite(&random_value, sizeof(uint32_t), 1, fout);
        if (ferror(fout)) {
            perror("fwrite");
            return 1;
        }
    }

    fclose(fout);

    return 0;
}
