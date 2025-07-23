// --------------------------------------------------------
// Výpočet hodnot funkce log() pomocí iteračního
// algoritmu CORDIC.
// --------------------------------------------------------

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

// maximální počet iterací při běhu algoritmu
#define MAXITER 10

// "zesílení" při rotacích (odpovídá ln(2))
#define K 0.69314718056

// ln(1+2*(-i))
double tabp[MAXITER] =
{ 
    0.40546510810816,
    0.22314355131421,
    0.11778303565638,
    0.06062462181643,
    0.03077165866675,
    0.01550418653597,
    0.00778214044205,
    0.00389864041566,
    0.00195122013126,
    0.00097608597306,
};

// ln(1-2*(-i))
double tabm[MAXITER] =
{
    -0.69314718055995,
    -0.28768207245178,
    -0.13353139262452,
    -0.06453852113757,
    -0.03174869831458,
    -0.01574835696814,
    -0.00784317746103,
    -0.00391389932114,
    -0.00195503483580,
    -0.00097703964783,
};

// výpočet logaritmu algoritmem CORDIC
double log_cordic(double a)
{
    const double three_eigth = 0.375;
    int sk, expo;
    double sum = tabm[0];
    double x = 2.0 * frexpf (a, &expo);
    double ex2 = 1.0; // dvojková mocnina
    int k;

    for (k = 0; k < MAXITER; k++) {
        sk = 0;
        // zjistit směr rotace
        if ((x - 1.0) <  (-three_eigth * ex2)) {
            sk = +1;
        }
        if ((x - 1.0) >= (+three_eigth * ex2)) {
            sk = -1;
        }
        ex2 /= 2.0;
        if (sk == 1) { // přímá rotace
            x = x + x * ex2;
            sum = sum - tabp [k];
        } 
        if (sk == -1) { // opačná rotace
            x = x - x * ex2;
            sum = sum - tabm [k];
        }
    }
    return expo * K + sum; // přepočet logaritmu
}


int main (void) {
    double a = M_E - 2.0; // "pěkná" počáteční hodnota

    for (; a<=2.0*M_E; a+=0.1) {
        double log_value = log_cordic(a);
        double log_correct = log(a);
        double log_error = fabs(log_correct - log_value);
        // tisk výsledků
        printf("%5.3f\t%12.10f\t%12.10f\t%8.3f%%\n",
               a,
               log_value,
               log_error,
               (log_value != 0.0) ? 100.0 * log_error / fabs(log_value) : 0.0);
    }
    return 0;
}

// finito
