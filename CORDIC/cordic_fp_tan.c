// --------------------------------------------------------
// Výpočet hodnot funkce tan() pomocí iteračního algoritmu
// CORDIC.
// --------------------------------------------------------

#include <math.h>
#include <stdio.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

// maximální počet iterací při běhu algoritmu
#define MAX_ITER 10

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

// výpočet funkce tan() pro zadaný úhel delta
double tan_cordic(double delta) {
    int    i;
    double x0 = 1.0; // nastavení počátečních podmínek
    double y0 = 0.0;
    double xn;
    if (delta == 0) {
        return 0.0; // ošetření nulového úhlu
    }
    for (i = 0; i < MAX_ITER; i++) { // iterační smyčka
        if (delta < 0) {             // úhel je záporný => rotace doleva
            xn = x0 + y0 * pows[i];
            y0 -= x0 * pows[i];
            delta += atans[i];
        } else { // úhel je kladný => rotace doprava
            xn = x0 - y0 * pows[i];
            y0 += x0 * pows[i];
            delta -= atans[i];
        }
        x0 = xn;
    }
    if (x0 == 0) { // ošetření tangenty pravého úhlu
        if (y0 > 0) {
            return INFINITY;
        } else {
            return -INFINITY;
        }
    } else {
        return y0 / x0;
    }
}

int main(void) {
    int i;
    createTables();
    for (i = 0; i <= 90; i++) {                   // výpočetní smyčka
        double delta;                             // úhel, ze kterého se počítá sin a cos
        double tan_value;                         // vypočtené hodnoty
        double tan_error;                         // absolutní chyby
        delta = i * M_PI / 180.0;                 // převod úhlu na radiány
        tan_value = tan_cordic(delta);            // výpočet funkce tan
        tan_error = fabs(tan_value - tan(delta)); // výpočet absolutních chyb
        // tisk výsledků
        printf("%02d\t%14.10f\t%14.10f\t%12.10f\t%8.3f%%\n",
               i,
               tan_value,
               tan(delta), tan_error,
               tan_error == 0.0 ? 0 : 100.0 * tan_error / tan(delta));
    }
    return 0;
}

// finito
