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
        subps xmm0, xmm1             ; rozdil prvku vektoru
        mulps xmm0, xmm1             ; soucin prvku vektoru
        divps xmm0, xmm1             ; podil prvku vektoru
        maxps xmm0, xmm1             ; vyber vetsich prvku
        minps xmm0, xmm1             ; vyber mensich prvku
        sqrtps xmm0, xmm0            ; vypocet druhe odmocniny
        rcpps xmm0, xmm0             ; vypocet prevracenych hodnot

        addss xmm0, xmm1             ; skalarni soucet
        subss xmm0, xmm1             ; rozdil skalaru
        mulss xmm0, xmm1             ; soucin skalaru
        divss xmm0, xmm1             ; podil skalaru
        maxss xmm0, xmm1             ; vyber vetsich skalaru
        maxss xmm0, xmm1             ; vyber mensich skalaru

	cmpeqps xmm0, xmm1           ; porovnani prvku vektoru
	cmpltps xmm0, xmm1           ; porovnani prvku vektoru
	cmpleps xmm0, xmm1           ; porovnani prvku vektoru
	cmpunordps xmm0, xmm1        ; porovnani prvku vektoru
	cmpneqps xmm0, xmm1          ; porovnani prvku vektoru
	cmpnltps xmm0, xmm1          ; porovnani prvku vektoru
	cmpnleps xmm0, xmm1          ; porovnani prvku vektoru
	cmpordps xmm0, xmm1          ; porovnani prvku vektoru

	unpckhps xmm0, xmm1           ; prolozeni prvku dvou vektoru
	unpcklps xmm0, xmm1           ; prolozeni prvku dvou vektoru
        shufps xmm0, xmm1, 0b11111111 ; prolozeni prvku dvou vektoru

        cvtsi2ss xmm0, eax           ; konverze jednoho prvku
	cvtss2si eax, xmm0           ; konverze jednoho prvku

	ldmxcsr [ebx]                ; načtení nové hodnoty
	stmxcsr [ebx]                ; uložení hodnoty MXCSR
