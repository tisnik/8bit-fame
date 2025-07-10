#include <math.h>
#include <stdio.h>
#include <stdlib.h>

/* tato funkce provede jednu iteraci
 * se zlepšeným odhadem výsledku x_i
 */
float sqrt_step(float xi, float y)
{
    return 1.0 / 2.0 * (xi + y / xi);
}

int main(void) {
    /* vstupní hodnota, ze které se počítá odmocnina */
    double y = 10000;

    /* postupně zpřesňovaný odhad výsledku */
    double xi = y;

    /* hodnota pro porovnání výsledků */
    double sqr = sqrt(y);

    /* počitadlo iterací */
    int i;

    /* iterativní výpočet */
    for (i = 0; i < 20; i++) {
        double abs_error, rel_error;
        xi = sqrt_step(xi, y);                      /* zpřesnění odhadu */
        abs_error = fabs(xi - sqr);                 /* absolutní chyba */ 
        rel_error = 100.0f * fabs(xi - sqr) / sqr;  /* relativní chyba */
        printf("%d\t%11.5f\t%11.5f\t%10.2f%%\n", i + 1, xi, abs_error, rel_error);
    }
    return 0;
}

/* finito */
