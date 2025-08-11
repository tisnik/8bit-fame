#include <stdio.h>
#include <stdint.h>

int main(void) {
    FILE *fout;

    int success;
    uint32_t random_value;
    int i;

    fout = fopen("random.bin", "wb");
    if (fout == NULL) {
        perror("fopen");
        return 1;
    }

    for (i=0; i<10; i++) {
        success = __builtin_ia32_rdrand32_step(&random_value);
        if (success != 1) {
            perror("rdrand32");
            return 2;
        }
        fwrite(&random_value, sizeof(uint32_t), 1, fout);
        if (ferror(fout)) {
            perror("fwrite");
            return 1;
        }
    }

    fclose(fout);

    return 0;
}

