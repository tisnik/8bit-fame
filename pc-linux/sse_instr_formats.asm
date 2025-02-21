[bits 32]
 
;-----------------------------------------------------------------------------
section .text
        movaps xmm0, [ebx]           ; nacteni prvni hodnoty do registru XMM0
        addps xmm0, xmm1             ; soucet vektoru
