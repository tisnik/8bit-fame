/* vypis stavu polycitace */
#include <stdio.h>
#include <stdlib.h>

#define POLYCOUNTER_LENGTH 5
#define BIT_A_INDEX 3
#define BIT_B_INDEX 5

/* vypis vsech bitu polycitace */
void printPoly( int polycounter )
{
    int i;
    /* pro vsechny bity posuvneho registru */
    for ( i=0; i<POLYCOUNTER_LENGTH; i++ )
    {
        /* vypis binarni hodnoty jednoho bitu */
        putchar('0'+ (polycounter & 1) );
        /* posun na dalsi bit */
        polycounter = polycounter >> 1;
    }
    putchar('\n');
}

int main(void)
{
    /* pocatecni hodnota polycitace */
    int polycounter = 1;
    int i;
    for ( i=0; i < (1<<POLYCOUNTER_LENGTH); i++ )
    {
        int bitA, bitB, inputBit;

        /* vypis hodnoty pocitadla i hexadecimalni hodnoty polycitace */
        /* hodnota polycitace musi byt maskovana na svou max. bitovou delku */
        printf("%02d\t%02x\t", i+1, polycounter & ((1<<POLYCOUNTER_LENGTH)-1));
        /* vypis vsech bitu polycitace */
        printPoly(polycounter);

        /* ziskani hodnoty prvniho bitu, ktery jde do zpetnovazebni smycky */
        bitA = (polycounter >> (BIT_A_INDEX-1) ) & 1;

        /* ziskani hodnoty druheho bitu, ktery jde do zpetnovazebni smycky */
        bitB = (polycounter >> (BIT_B_INDEX-1) ) & 1;

        /* simulace funkce hradla typu XOR */
        inputBit = bitA ^ bitB;

        /* posun o jeden bit doleva a nastaveni */
        /* nove hodnoty prvniho bitu (LSB) */
        polycounter = (polycounter << 1) | inputBit;
    }
    return 0;
}
