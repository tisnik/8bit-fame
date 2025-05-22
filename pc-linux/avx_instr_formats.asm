[bits 32]
 
;-----------------------------------------------------------------------------
section .text
        vmovdqu ymm0, [ebx]          ; nacteni vektoru do registru YMM0

        vpaddb ymm2, ymm0, ymm1      ; ymm2 = ymm0 + ymm1 (po bajtech)
        vpaddw ymm2, ymm0, ymm1      ; ymm2 = ymm0 + ymm1 (po slovech)
        vpaddd ymm2, ymm0, ymm1      ; ymm2 = ymm0 + ymm1 (po dvojslovech)
        vpaddq ymm2, ymm0, ymm1      ; ymm2 = ymm0 + ymm1 (po ctyrslovech)

        ; různé varianty registrů u stejné instrukce
        vpaddb ymm0, ymm0, ymm0
        vpaddb ymm0, ymm0, ymm1
        vpaddb ymm0, ymm1, ymm0
        vpaddb ymm0, ymm1, ymm1
        vpaddb ymm1, ymm0, ymm0
        vpaddb ymm1, ymm0, ymm1
        vpaddb ymm1, ymm1, ymm0
        vpaddb ymm1, ymm1, ymm1

        vbroadcastss ymm0, [ebx]     ; broadcasting do vsech prvku vektoru YMM0
        vbroadcastss xmm0, [ebx]     ; broadcasting do vsech prvku vektoru XMM0
        vbroadcastsd ymm0, [ebx]     ; broadcasting do vsech prvku vektoru YMM0

        vzeroall                     ; vynulování všech prvků registrů
        vzeroupper                   ; vynulování všech horních prvků registrů

        vgatherdps ymm1, [ebx+ymm2], ymm3
        vgatherdps ymm1, [ebx+ymm2*2], ymm3
        vgatherdps ymm1, [ebx+ymm2*4], ymm3
        vgatherdps ymm1, [ebx+ymm2*8], ymm3
