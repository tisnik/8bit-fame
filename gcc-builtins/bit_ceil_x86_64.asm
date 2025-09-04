bit_ceil_8bit:
        mov     eax, 1
        cmp     dil, 1
        jbe     .L1
        lea     ecx, [rdi-1]
        mov     eax, 2
        movzx   ecx, cl
        bsr     ecx, ecx
        sal     eax, cl
        movzx   eax, al
.L1:
        ret

bit_ceil_16bit:
        mov     eax, 1
        cmp     di, 1
        jbe     .L5
        lea     ecx, [rdi-1]
        mov     eax, 2
        movzx   ecx, cx
        bsr     ecx, ecx
        sal     eax, cl
        movzx   eax, ax
.L5:
        ret

bit_ceil_32bit:
        mov     eax, 1
        cmp     edi, 1
        jbe     .L9
        sub     edi, 1
        mov     eax, 2
        bsr     ecx, edi
        sal     eax, cl
.L9:
        ret

bit_ceil_64bit:
        mov     eax, 1
        cmp     rdi, 1
        jbe     .L11
        sub     rdi, 1
        mov     eax, 2
        bsr     rcx, rdi
        sal     rax, cl
.L11:
        ret
