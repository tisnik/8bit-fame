parity_char:
        xor     eax, eax
        test    dil, dil
        setnp   al
        ret

parity_int:
        mov     eax, edi
        shr     eax, 16
        xor     eax, edi
        xor     al, ah
        setnp   al
        movzx   eax, al
        ret

parity_long:
        mov     rax, rdi
        shr     rax, 32
        xor     eax, edi
        mov     edx, eax
        shr     edx, 16
        xor     eax, edx
        xor     al, ah
        setnp   al
        movzx   eax, al
        ret

parity_long_long:
        mov     rax, rdi
        shr     rax, 32
        xor     eax, edi
        mov     edx, eax
        shr     edx, 16
        xor     eax, edx
        xor     al, ah
        setnp   al
        movzx   eax, al
        ret
