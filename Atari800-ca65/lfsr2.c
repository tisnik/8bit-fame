/* simulace funkce polycitace (polycounteru) */
#include <stdio.h>
#include <stdlib.h>

#define POLYCOUNTER_LENGTH 5
#define BIT_A_INDEX 3
#define BIT_B_INDEX 5

int main(void)
{
    /* pocatecni hodnota polycitace */
    int polycounter = 1;
    int i,j;
    /* projdeme pres nekolik period, aby bylo patrne, ze se hodnoty opakuji */
    for ( j=0; j < 10; j++ )
    {
        /* vypis cele jedne periody polycitace */
        for ( i=0; i < (1<<POLYCOUNTER_LENGTH)-1; i++ )
        {
            int bitA, bitB, inputBit, outputBit;

            /* ziskani hodnoty prvniho bitu, ktery jde do zpetnovazebni smycky */
            bitA = (polycounter >> (BIT_A_INDEX-1) ) & 1;

            /* ziskani hodnoty druheho bitu, ktery jde do zpetnovazebni smycky */
            bitB = (polycounter >> (BIT_B_INDEX-1) ) & 1;

            /* nejvyssi bit polycitace tvori i jeho vystup */
            outputBit = (polycounter >> (POLYCOUNTER_LENGTH-1) ) & 1;

            /* vypis vystupni hodnoty */
            putchar('0' + outputBit);

            /* simulace funkce hradla typu XOR */
            inputBit = bitA ^ bitB;

            /* posun o jeden bit doleva a nastaveni */
            /* nove hodnoty prvniho bitu (LSB) */
            polycounter = (polycounter << 1) | inputBit;
        }
        putchar('\n');
    }
    return 0;
}
