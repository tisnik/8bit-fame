        .file   "fill_a.c"
        .intel_syntax noprefix
        .text
        .p2align 4
        .globl  fill_array
        .type   fill_array, @function
fill_array:
.LFB0:
        .cfi_startproc
        mov     r8, rdi
        mov     ecx, esi
        test    esi, esi
        jle     .L1
        lea     eax, [rsi-1]
        cmp     eax, 2
        jbe     .L6
        shr     esi, 2
        movd    xmm1, edx
        mov     rax, rdi
        sal     rsi, 4
        pshufd  xmm0, xmm1, 0
        lea     rdi, [rsi+rdi]
        and     esi, 16
        je      .L4
        lea     rax, [r8+16]
        movups  XMMWORD PTR [r8], xmm0
        cmp     rax, rdi
        je      .L13
        .p2align 4
        .p2align 4
        .p2align 3
.L4:
        movups  XMMWORD PTR [rax], xmm0
        add     rax, 32
        movups  XMMWORD PTR [rax-16], xmm0
        cmp     rax, rdi
        jne     .L4
.L13:
        mov     eax, ecx
        and     eax, -4
        test    cl, 3
        je      .L15
.L3:
        movsx   rsi, eax
        mov     DWORD PTR [r8+rsi*4], edx
        lea     rdi, [0+rsi*4]
        lea     esi, [rax+1]
        cmp     ecx, esi
        jle     .L1
        add     eax, 2
        mov     DWORD PTR [r8+4+rdi], edx
        cmp     ecx, eax
        jle     .L1
        mov     DWORD PTR [r8+8+rdi], edx
.L1:
        ret
        .p2align 4,,10
        .p2align 3
.L15:
        ret
.L6:
        xor     eax, eax
        jmp     .L3
        .cfi_endproc
.LFE0:
        .size   fill_array, .-fill_array
        .ident  "GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
        .section        .note.GNU-stack,"",@progbits
