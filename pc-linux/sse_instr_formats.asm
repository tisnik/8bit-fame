;
; Tento demonstracni priklad je pouzity v serialu o programovani
; grafickych dem a her na PC v DOSu:
; https://www.root.cz/serialy/vyvoj-her-a-grafickych-dem-pro-platformu-pc/
;
; Clanek, kde je tento demonstracni priklad pouzit:
; 
; SIMD instrukce v rozšíření SSE
; https://www.root.cz/clanky/simd-instrukce-v-rozsireni-sse/

[bits 32]
 
;-----------------------------------------------------------------------------
section .text
        movups xmm0, [ebx]           ; nacteni hodnoty do registru XMM0
        movaps xmm0, [ebx]           ; nacteni hodnoty do registru XMM0
	movups xmm0, xmm1            ; prenosy mezi registry
        addps xmm0, xmm1             ; soucet prvku vektoru
        addss xmm0, xmm1             ; skalarni soucet
        subps xmm0, xmm1             ; rozdil prvku vektoru
        subss xmm0, xmm1             ; rozdil skalaru
        mulps xmm0, xmm1             ; soucin prvku vektoru
        mulss xmm0, xmm1             ; soucin skalaru
        divps xmm0, xmm1             ; podil prvku vektoru
        divss xmm0, xmm1             ; podil skalaru
        maxps xmm0, xmm1             ; vyber vetsich prvku
        maxss xmm0, xmm1             ; vyber vetsich skalaru
        minps xmm0, xmm1             ; vyber mensich prvku
        maxss xmm0, xmm1             ; vyber mensich skalaru
