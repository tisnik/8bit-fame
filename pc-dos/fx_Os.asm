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
