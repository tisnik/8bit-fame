sub_overflow_signed_char:
        sub     dil, sil
        seto    al
        ret
        
sub_overflow_unsigned_char:
        cmp     sil, dil
        seta    al
        ret
        
sub_overflow_signed_short:
        sub     di, si
        seto    al
        ret
        
sub_overflow_unsigned_short:
        cmp     si, di
        seta    al
        ret
        
sub_overflow_signed_int:
        sub     edi, esi
        seto    al
        ret
        
sub_overflow_unsigned_int:
        cmp     edi, esi
        setb    al
        ret
        
sub_overflow_signed_long:
        sub     rdi, rsi
        seto    al
        ret
        
sub_overflow_unsigned_long:
        cmp     rdi, rsi
        setb    al
        ret
