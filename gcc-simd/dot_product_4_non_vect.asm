        .file   "dot_product_4.c"
        .intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#       compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -fno-tree-vectorize
        .text
        .p2align 4
        .globl  dot_product_4
        .type   dot_product_4, @function
dot_product_4:
.LFB0:
        .cfi_startproc
# dot_product_4.c:1: float dot_product_4(float *a, float *b) {
        xor     eax, eax        # ivtmp.12
# dot_product_4.c:4:     float result = 0.0;
        pxor    xmm1, xmm1      # <retval>
.L2:
# dot_product_4.c:6:         result += a[i] * b[i];
        movss   xmm0, DWORD PTR [rdi+rax]       # MEM[(float *)a_11(D) + ivtmp.12_21 * 1], MEM[(float *)a_11(D) + ivtmp.12_21 * 1]
        mulss   xmm0, DWORD PTR [rsi+rax]       # _7, MEM[(float *)b_12(D) + ivtmp.12_21 * 1]
# dot_product_4.c:5:     for (i=0; i<SIZE; i++) {
        add     rax, 4  # ivtmp.12,
# dot_product_4.c:6:         result += a[i] * b[i];
        addss   xmm1, xmm0      # <retval>, _7
# dot_product_4.c:5:     for (i=0; i<SIZE; i++) {
        cmp     rax, 16 # ivtmp.12,
        jne     .L2     #,
# dot_product_4.c:9: }
        movaps  xmm0, xmm1      #, <retval>
        ret     
        .cfi_endproc
.LFE0:
        .size   dot_product_4, .-dot_product_4
        .ident  "GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
        .section        .note.GNU-stack,"",@progbits
