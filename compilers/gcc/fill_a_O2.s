        .file   "fill_a.c"
        .intel_syntax noprefix
        .text
        .p2align 4
        .globl  fill_array
        .type   fill_array, @function
fill_array:
.LFB0:
        .cfi_startproc
        test    esi, esi
        jle     .L1
        movsx   rsi, esi
        lea     rax, [rdi+rsi*4]
        and     esi, 1
        je      .L3
        mov     DWORD PTR [rdi], edx
        add     rdi, 4
        cmp     rdi, rax
        je      .L11
        .p2align 4
        .p2align 4
        .p2align 3
.L3:
        mov     DWORD PTR [rdi], edx
        add     rdi, 8
        mov     DWORD PTR [rdi-4], edx
        cmp     rdi, rax
        jne     .L3
.L1:
        ret
.L11:
        ret
        .cfi_endproc
.LFE0:
        .size   fill_array, .-fill_array
        .ident  "GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
        .section        .note.GNU-stack,"",@progbits
