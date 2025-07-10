#include <math.h>
#include <stdio.h>
#include <stdlib.h>

/* počet míst před a za binární řádovou tečkou */
#define A 16
#define B 16

/* datový typ, se kterým budeme pracovat */
typedef int32_t fx;

/* hlavičky použitých funkcí */
void fx_print(fx x);
fx fp2fx(double x);
double fx2fp(fx x);

/*
 * Tisk numerické hodnoty uložené ve formátu pevné
 * řádové binární čárky (FX)
 */
void fx_print(fx x)
{
    int i;
    int val = x;                /* pomocná proměnná pro převod do dvojkové soustavy */
    printf("bin: ");
    for (i = 0; i < A + B; i++) {       /* převod na řetězec bitů (do dvojkové soustavy) */
        putchar(!!(val & (1 << (A + B - 1))) + '0');    /* výpis hodnoty aktuálně nejvyššího bitu */
        if (i == B - 1)
            putchar('.');       /* po řádové binární čárce vypsat značku */
        val = val << 1;         /* posun na další (méně významný) bit */
    }

    printf("   hex: %08x   fp: %+11.5f\n", x, fx2fp(x));
}

/*
 * Převod z formátu plovoucí řádové binární čárky (FP)
 * do formátu pevné řádové binární čárky (FX)
 */
fx fp2fx(double x)
{
    return (fx) (x * (2 << (B - 1)));
}

/*
 * Převod z celočíselného formátu (integer)
 * do formátu pevné řádové binární čárky (FX)
 */
fx int2fx(int x)
{
    return (fx) (x << B);
}

/*
 * Převod z formátu pevné řádové binární čárky (FX)
 * do formátu plovoucí řádové binární čárky (FP)
 */
double fx2fp(fx x)
{
    return (double) x / (2 << (B - 1));
}

/*
 * Součet dvou hodnot uložených ve shodném formátu
 * pevné binární řádové čárky (FX)
 */
fx fx_add(fx x, fx y)
{
    return x + y;
}

/*
 * Rozdíl dvou hodnot uložených ve shodném formátu
 * pevné binární řádové čárky (FX)
 */
fx fx_sub(fx x, fx y)
{
    return x - y;
}

/*
 * Součin dvou hodnot uložených ve shodném formátu
 * pevné binární řádové čárky (FX)
 */
fx fx_mul(fx x, fx y)
{
    fx result = (x >> (B / 2)) * (y >> (B / 2));
    return result;
}

/*
 * Podíl dvou hodnot uložených ve shodném formátu
 * pevné binární řádové čárky (FX)
 */
fx fx_div(fx x, fx y)
{
    fx result = x / (y >> (B / 2));
    return result << (B / 2);
}

/* jeden krok odhadu druhé odmocniny */
fx sqrt_step_calc(fx f1, fx f2, fx xi, fx y)
{
    return fx_mul(fx_div(f1, f2), xi + fx_div(y, xi));
}

/* tato funkce provede jednu iteraci
 * se zlepšeným odhadem výsledku x_i
 */
fx sqrt_step(fx xi, fx y)
{
    fx f1 = fp2fx(1.0);
    fx f2 = fp2fx(2.0);
    return sqrt_step_calc(f1, f2, xi, y);
}

int main(void) {
    double orig_y = 10000.0;

    /* vstupní hodnota, ze které se počítá odmocnina */
    fx y = fp2fx(orig_y);

    /* postupně zpřesňovaný odhad výsledku */
    fx xi = y;

    /* hodnota pro porovnání výsledků */
    double sqr = sqrt(orig_y);

    /* počitadlo iterací */
    int i;

    /* iterativní výpočet */
    for (i = 0; i < 20; i++) {
        double abs_error, rel_error;
        double xf;
        xi = sqrt_step(xi, y);                      /* zpřesnění odhadu */
        xf = fx2fp(xi);                             /* převést na FP pro výpočty a tisk */
        abs_error = fabs(xf - sqr);                 /* absolutní chyba */ 
        rel_error = 100.0f * fabs(xf - sqr) / sqr;  /* relativní chyba */
        printf("%d\t%11.5f\t%11.5f\t%10.2f%%\n", i + 1, xf, abs_error, rel_error);
    }
    return 0;
}

/* finito */
