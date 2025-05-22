     1                                  [bits 32]
     2                                   
     3                                  ;-----------------------------------------------------------------------------
     4                                  section .text
     5 00000000 C5FE6F03                        vmovdqu ymm0, [ebx]          ; nacteni vektoru do registru YMM0
     6                                  
     7 00000004 C5FDFCD1                        vpaddb ymm2, ymm0, ymm1      ; ymm2 = ymm0 + ymm1 (po bajtech)
     8 00000008 C5FDFDD1                        vpaddw ymm2, ymm0, ymm1      ; ymm2 = ymm0 + ymm1 (po slovech)
     9 0000000C C5FDFED1                        vpaddd ymm2, ymm0, ymm1      ; ymm2 = ymm0 + ymm1 (po dvojslovech)
    10 00000010 C5FDD4D1                        vpaddq ymm2, ymm0, ymm1      ; ymm2 = ymm0 + ymm1 (po ctyrslovech)
    11                                  
    12                                          ; různé varianty registrů u stejné instrukce
    13 00000014 C5FDFCC0                        vpaddb ymm0, ymm0, ymm0
    14 00000018 C5FDFCC1                        vpaddb ymm0, ymm0, ymm1
    15 0000001C C5F5FCC0                        vpaddb ymm0, ymm1, ymm0
    16 00000020 C5F5FCC1                        vpaddb ymm0, ymm1, ymm1
    17 00000024 C5FDFCC8                        vpaddb ymm1, ymm0, ymm0
    18 00000028 C5FDFCC9                        vpaddb ymm1, ymm0, ymm1
    19 0000002C C5F5FCC8                        vpaddb ymm1, ymm1, ymm0
    20 00000030 C5F5FCC9                        vpaddb ymm1, ymm1, ymm1
    21                                  
    22 00000034 C4E27D1803                      vbroadcastss ymm0, [ebx]     ; broadcasting do vsech prvku vektoru YMM0
    23 00000039 C4E2791803                      vbroadcastss xmm0, [ebx]     ; broadcasting do vsech prvku vektoru XMM0
    24 0000003E C4E27D1903                      vbroadcastsd ymm0, [ebx]     ; broadcasting do vsech prvku vektoru YMM0
    25                                  
    26 00000043 C5FC77                          vzeroall                     ; vynulování všech prvků registrů
    27 00000046 C5F877                          vzeroupper                   ; vynulování všech horních prvků registrů
    28                                  
    29 00000049 C4E265920C13                    vgatherdps ymm1, [ebx+ymm2], ymm3
    30 0000004F C4E265920C53                    vgatherdps ymm1, [ebx+ymm2*2], ymm3
    31 00000055 C4E265920C93                    vgatherdps ymm1, [ebx+ymm2*4], ymm3
    32 0000005B C4E265920CD3                    vgatherdps ymm1, [ebx+ymm2*8], ymm3
