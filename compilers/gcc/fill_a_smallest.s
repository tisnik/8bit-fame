        .file   "fill_a.c"
        .intel_syntax noprefix
        .text
        .globl  fill_array
        .type   fill_array, @function
fill_array:
.LFB0:
        .cfi_startproc
        xor     eax, eax
.L2:
        cmp     esi, eax
        jle     .L5
        mov     DWORD PTR [rdi+rax*4], edx
        inc     rax
        jmp     .L2
.L5:
        ret
        .cfi_endproc
.LFE0:
        .size   fill_array, .-fill_array
        .ident  "GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
        .section        .note.GNU-stack,"",@progbits
