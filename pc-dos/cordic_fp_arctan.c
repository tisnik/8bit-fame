// --------------------------------------------------------
// Výpočet hodnot funkce atan() pomocí iteračního algoritmu
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

// výpočet funkce atan() pro zadané souřadnice x, y
double atan_cordic(double y, double x) {
    int i;
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
    return delta; // výsledek je uložen v akumulátoru úhlu
}

int main(void) {
    double i;
    createTables();
    for (i = 0.0; i < 1.05; i += 0.05) { // výpočetní smyčka
        double atan_value;               // vypočtená hodnoty
        double atan_error;               // absolutní chyba
        double atan_float;               // korektní hodnota

        atan_value = atan_cordic((double)i, 1.0) * 180.0 / M_PI; // výpočet funkce atan
        atan_float = atan(i) * 180.0 / M_PI;
        atan_error = fabs(atan_value - atan_float); // výpočet absolutní chyby
                                             // tisk výsledků
        printf("%3.2f\t%14.10f\t%14.10f\t%12.10f\t%8.3f%%\n",
               i,
               atan_value,
               atan_float, atan_error,
               atan_float == 0 ? 0 : 100.0 * atan_error / atan_float);
    }
    // důkaz, že atan se spočte i pro nekonečno, tj. pravý úhel:
    printf("\natan nekonecna: %f\n", atan_cordic(1.0, 0.0) * 180.0 / M_PI);
    return 0;
}

// finito
