#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#define EPSILON 10.0e-20

/* tato funkce provede výpočet funkce
 * sin() pomocí tří nenulových členů
 * Taylorova rozvoje
 */
double compute_sin(double x)
{
    double t1=x/1.0;
    double t3=x*x*x/6.0;
    double t5=x*x*x*x*x/120.0;
    return t1-t3+t5;
}

int main(void)
{
    /* počitadlo iterací */
    double alfa;
    for (alfa=0.0; alfa<=M_PI/2.0; alfa+=M_PI/40.0) {
        /* korektní výpočet */
        double sin1=sin(alfa);

        /* náš odhad */
        double sin2=compute_sin(alfa);

        /* absolutní chyba */ 
        double abs_error = fabs(sin2-sin1);

        /* relativní chyba */
        double rel_error = fabs(sin1)<EPSILON ? 0.0 : 100.0*fabs(sin2-sin1)/sin1;
        printf("%5.3f\t%8.6f\t%8.6f\t%8.6f\t%6.2f%%\n",
                alfa,
                sin1,
                sin2,
                abs_error,
                rel_error);
    }
    return 0;
}

/* finito */

