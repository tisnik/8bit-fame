#include <stdlib.h>
#include <stdio.h>
#include <math.h>

/* počet míst před a za binární řádovou tečkou */
#define A 16
#define B 16

/* Ludolfovo číslo */
#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

/* maximální počet iterací při běhu algoritmu */
#define MAX_ITER 16

/* "zesílení" při rotacích */
#define K_float 0.6073

/* převody mezi stupni a radiány */
#define rad2deg(rad) ((rad) * 180.0 / M_PI)
#define deg2rad(deg) ((deg) / 180.0 * M_PI)

/* datový typ, se kterým budeme pracovat */
typedef signed int fx;

/* hlavičky použitých funkcí */
void fx_print(fx x);
fx fp2fx(double x);
double fx2fp(fx x);

/* tabulka arkustangentu úhlů */
fx atans[MAX_ITER];

/* tabulka záporných celočíselných mocnin hodnoty 2 */
fx pows[MAX_ITER];

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

/*
 * Vytvoření tabulky pro výpočet goniometrických
 * funkcí pomocí algoritmu CORDIC
 */
void fx_create_tables(void)
{
    int i;
    for (i = 0; i < MAX_ITER; i++) {
        double p = pow(2.0, -i);
        atans[i] = fp2fx(atan(p));
        pows[i] = fp2fx(p);
    }
}


/* výpočet funkce tan() pro zadaný úhel delta */
/* (optimalizovaná verze) */
fx fx_tan_cordic_optim(fx delta)
{
    int i;
    /* nastavení počátečních podmínek */
    fx x0 = int2fx(1);
    fx y0 = 0;
    fx xn;
    if (delta == 0)
        return 0;               /* ošetření nulového úhlu */
    for (i = 0; i < MAX_ITER; i++) {    /* iterační smyčka */
        if (delta < 0) {        /* úhel je záporný =&gt; rotace doleva */
            xn = fx_add(x0, y0 >> i);   /* místo násobení bitový posuv */
            y0 = fx_sub(y0, x0 >> i);
            delta = fx_add(delta, atans[i]);
        } else {                /* úhel je kladný =&gt; rotace doprava */
            xn = fx_sub(x0, y0 >> i);
            y0 = fx_add(y0, x0 >> i);
            delta = fx_sub(delta, atans[i]);
        }
        x0 = xn;
    }
    if (x0 == 0)                /* ošetření tangenty pravého úhlu */
        if (y0 < 0)
            return 0;
        else
            return 0;
    else
        return fx_div(y0, x0);  /* vrátit výsledek operace */
}


int main(void)
{
    int i;
    fx tanfx;
    double delta;               /* úhel, ze kterého se funkce počítá */
    double tan_value;           /* absolutní chyby */
    double tan_error;           /* relativní chyby */

    fx_create_tables();

    /* výpis tabulky tangent úhlů v rozsahu 0..89° */
    for (i=0; i<90; i++) {                         /* výpočetní smyčka */
        delta=deg2rad(i);                          /* převod úhlu na radiány */
        tanfx=fx_tan_cordic_optim(fp2fx(delta));   /* aplikace algoritmu CORDIC */
        tan_value=fx2fp(tanfx);                    /* výpočet funkce tan */
        tan_error=fabs(tan_value-tan(delta));      /* výpočet absolutních chyb */
                                                   /* tisk výsledků */
        printf("%02d\t%14.10f\t%14.10f\t%12.10f\t%8.3f%%\n",
                i,
                tan_value,
                tan(delta),
                tan_error,
                tan_error==0 ? 0:100.0*tan_error/tan(delta));
    }

    return 0;
}

// finito
