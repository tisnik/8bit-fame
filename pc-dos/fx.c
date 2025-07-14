/*
 *
 * Tento demonstracni priklad je pouzity v serialu o programovani
 * grafickych dem a her na PC v DOSu:
 * https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
 *
 * Clanek, kde je tento demonstracni priklad pouzit:
 * Výpočty v systému pevné řádové čárky na platformě IBM PC (2. část)
 * https://www.root.cz/clanky/vypocty-v-systemu-pevne-radove-carky-na-platforme-ibm-pc-2-cast/
 *
*/

#include <stdint.h>

uint32_t fx_add(uint32_t x, uint32_t y) {
    return x+y;
}

uint32_t fx_mul_1(uint32_t x, uint32_t y) {
    return (x>>8) * (y>>8);
}

uint32_t fx_mul_2(uint32_t x, uint32_t y) {
    return (x*y)>>16;
}

