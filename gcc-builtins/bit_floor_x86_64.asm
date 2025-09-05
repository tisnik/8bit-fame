bit_floor_8bit:
        xor     eax, eax
        test    dil, dil
        je      .L1
        movzx   edi, dil
        mov     eax, 1
        bsr     ecx, edi
        sal     eax, cl
        movzx   eax, al
.L1:
        ret

bit_floor_16bit:
        xor     eax, eax
        test    di, di
        je      .L5
        movzx   edi, di
        mov     eax, 1
        bsr     ecx, edi
        sal     eax, cl
        movzx   eax, ax
.L5:
        ret

bit_floor_32bit:
        mov     eax, edi
        test    edi, edi
        je      .L9
        bsr     ecx, edi
        mov     eax, -2147483648
        xor     ecx, 31
        shr     eax, cl
.L9:
        ret

bit_floor_64bit:
        xor     eax, eax
        test    rdi, rdi
        je      .L13
        movabs  rax, -9223372036854775808
        bsr     rcx, rdi
        xor     rcx, 63
        shr     rax, cl
.L13:
        ret

