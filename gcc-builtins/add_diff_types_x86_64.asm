add_overflow_ccc:
        add     sil, dil
        setc    al
        ret

add_overflow_cci:
        xor     eax, eax
        ret

add_overflow_cic:
        mov     esi, esi
        movzx   edi, dil
        add     rdi, rsi
        test    rdi, -256
        setne   al
        ret

add_overflow_cii:
        movzx   edi, dil
        add     edi, esi
        setc    al
        ret

add_overflow_icc:
        add     sil, dil
        setc    al
        ret

add_overflow_ici:
        movzx   esi, sil
        add     esi, edi
        setc    al
        ret

add_overflow_iic:
        mov     esi, esi
        mov     edi, edi
        add     rdi, rsi
        test    rdi, -256
        setne   al
        ret

add_overflow_iii:
        add     edi, esi
        setc    al
        ret
