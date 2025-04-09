        .file   "array_clear_size_8.c"
        .intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#       compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -ftree-vectorize
        .text
        .p2align 4
        .globl  clear
        .type   clear, @function
clear:
.LFB0:
        .cfi_startproc
# array_clear_size_8.c:5:         a[i] = 0.0;
        pxor    xmm0, xmm0      # tmp99
        movups  XMMWORD PTR [rdi], xmm0 # MEM <char[1:32]> [(void *)a_7(D)], tmp99
        movups  XMMWORD PTR [rdi+16], xmm0      # MEM <char[1:32]> [(void *)a_7(D)], tmp99
# array_clear_size_8.c:7: }
        ret     
        .cfi_endproc
.LFE0:
        .size   clear, .-clear
        .ident  "GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
        .section        .note.GNU-stack,"",@progbits
