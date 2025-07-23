// --------------------------------------------------------
// Výpočet hodnot funkcí sin() a cos() pomocí iteračního
// algoritmu CORDIC.
// --------------------------------------------------------

#include <math.h>
#include <stdio.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

// maximální počet iterací při běhu algoritmu
#define MAX_ITER 7

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

// výpočet funkcí sin() a cos() pro zadaný úhel delta
void sincos(double delta, double *sin_value, double *cos_value) {
    int i;
    double x0 = 1.0; // nastavení počátečních podmínek
    double y0 = 0.0;
    double xn;
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
    *sin_value = y0 * K; // opravit "zesílení" výsledku
    *cos_value = x0 * K;
}

int main(void) {
    int i;
    createTables();
    for (i = 0; i <= 90; i++) { // výpočetní smyčka
        double delta;           // úhel, ze kterého se počítá sin a cos
        double sin_value;          // vypočtené hodnoty
        double cos_value;
        double sin_error; // absolutní chyby
        double cos_error;
        delta = i * M_PI / 180.0;           // převod úhlu na radiány
        sincos(delta, &sin_value, &cos_value);    // výpočet sinu a kosinu
        sin_error = fabs(sin_value - sin(delta)); // výpočet absolutních chyb
        cos_error = fabs(cos_value - cos(delta));
        // tisk výsledků
        printf("%02d\t%12.10f\t%12.10f\t%12.10f\t%12.10f\t%8.3f%%\t%8.3f%%\n",
               i,
               sin_value,
               cos_value,
               sin_error,
               cos_error,
               (sin_value != 0.0) ? 100.0 * sin_error / fabs(sin_value) : 0.0,
               (cos_value != 0.0) ? 100.0 * cos_error / fabs(cos_value) : 0.0);
    }
    return 0;
}

// finito
