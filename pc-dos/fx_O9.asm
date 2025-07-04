;-----------------------------------------------------------------------------
;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; Výpočty v systému pevné řádové čárky na platformě IBM PC
; https://www.root.cz/clanky/vypocty-v-systemu-pevne-radove-carky-na-platforme-ibm-pc/
;
;-----------------------------------------------------------------------------

fx_add(unsigned int, unsigned int):
        lea     eax, [rdi+rsi]
        ret

fx_mul_1(unsigned int, unsigned int):
        shr     edi, 8
        shr     esi, 8
        mov     eax, edi
        imul    eax, esi
        ret

fx_mul_2(unsigned int, unsigned int):
        imul    edi, esi
        mov     eax, edi
        shr     eax, 16
        ret
