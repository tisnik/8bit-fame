find_max:
        xor     edx, edx
        xor     eax, eax
.L2:
        cmp     edx, esi
        jnb     .L5
        mov     ecx, DWORD PTR [rdi+rdx*4]
        cmp     eax, ecx
        cmovb   eax, ecx
        inc     rdx
        jmp     .L2
.L5:
        ret
