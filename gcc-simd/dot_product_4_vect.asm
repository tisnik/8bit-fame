        .file   "dot_product_4.c"
        .intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#       compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -ftree-vectorize
        .text
        .p2align 4
        .globl  dot_product_4
        .type   dot_product_4, @function
dot_product_4:
.LFB0:
        .cfi_startproc
# dot_product_4.c:6:         result += a[i] * b[i];
        movups  xmm1, XMMWORD PTR [rsi] # vect__6.10_26, MEM <vector(4) float> [(float *)b_12(D)]
# dot_product_4.c:6:         result += a[i] * b[i];
        movups  xmm0, XMMWORD PTR [rdi] # vect__4.7_9, MEM <vector(4) float> [(float *)a_11(D)]
# dot_product_4.c:6:         result += a[i] * b[i];
        mulps   xmm0, xmm1      # vect__7.11_27, vect__6.10_26
        movaps  xmm1, xmm0      # tmp108, vect__7.11_27
        movhlps xmm1, xmm0      # tmp108, vect__7.11_27
        addps   xmm1, xmm0      # tmp109, vect__7.11_27
        movaps  xmm0, xmm1      # tmp110, tmp109
        shufps  xmm0, xmm1, 85  # tmp110, tmp109,
        addps   xmm0, xmm1      # tmp107, tmp109
# dot_product_4.c:9: }
        ret     
        .cfi_endproc
.LFE0:
        .size   dot_product_4, .-dot_product_4
        .ident  "GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
        .section        .note.GNU-stack,"",@progbits
