// --------------------------------------------------------
// Výpočet délky vektoru pomocí iteračního algoritmu
// CORDIC.
// --------------------------------------------------------

#include <math.h>
#include <stdio.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

// maximální počet iterací při běhu algoritmu
#define MAX_ITER 20

// "zesílení" při rotacích
#define K 0.6073

// tabulka arkustangentu úhlů
double atans[MAX_ITER];

// tabulka záporných celočíselných mocnin hodnoty 2
double pows[MAX_ITER];

// naplnění tabulek atans[] a pows[]
void createTables(void) {
    int i;
    for (i = 0; i < MAX_ITER; i++) {
        double p = pow(2.0, -i);
        atans[i] = atan(p);
        pows[i] = p;
    }
}

// výpočet velikosti vektoru pomocí algoritmu CORDIC
double mag_cordic(double y, double x) {
    int    i;
    double x0 = x; // nastavení počátečních podmínek
    double y0 = y;
    double xn;
    double delta = 0.0;
    for (i = 0; i < MAX_ITER; i++) { // iterační smyčka
        if (y0 > 0) {                // kladná polorovina => rotace doleva
            xn = x0 + y0 * pows[i];
            y0 -= x0 * pows[i];
            delta += atans[i];
        } else { // záporná polorovina => rotace doprava
            xn = x0 - y0 * pows[i];
            y0 += x0 * pows[i];
            delta -= atans[i];
        }
        x0 = xn;
    }
    return x0 * K; // délka vektoru
}

int main(void) {
    double x, y;
    createTables();
    printf("%f\n", mag_cordic(3, 4));    // výpočet Pythagorova trojúhelníka
    for (y = 0.0; y <= 10.0; y += 1.0) { // tabulka velikostí různých vektorů
        for (x = 0.0; x <= 10.0; x += 1.0) {
            printf("%5.2f ", mag_cordic(x, y));
        }
        putchar('\n');
    }
    return 0;
}

// finito
