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
        movaps xmm0, [ebx]           ; nacteni prvni hodnoty do registru XMM0
        addps xmm0, xmm1             ; soucet vektoru
