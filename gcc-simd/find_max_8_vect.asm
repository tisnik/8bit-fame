        .file   "find_max_8.c"
        .intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#       compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -ftree-vectorize
        .text
        .p2align 4
        .globl  find_max_8
        .type   find_max_8, @function
find_max_8:
.LFB0:
        .cfi_startproc
# find_max_8.c:8:         if (a[i] > max) {
        movss   xmm0, DWORD PTR .LC1[rip]       # tmp106,
        movups  xmm1, XMMWORD PTR [rdi] # vect__5.8, MEM <vector(4) float> [(float *)a_9(D)]
        shufps  xmm0, xmm0, 0   # tmp106
        maxps   xmm1, xmm0      # vect__5.8, tmp106
# find_max_8.c:8:         if (a[i] > max) {
        movups  xmm0, XMMWORD PTR [rdi+16]      # vect__4.7_19, MEM <vector(4) float> [(float *)a_9(D) + 16B]
# find_max_8.c:8:         if (a[i] > max) {
        maxps   xmm0, xmm1      # vect__5.8_20, vect__5.8
        movaps  xmm1, xmm0      # tmp110, vect__5.8_20
        movhlps xmm1, xmm0      # tmp110, vect__5.8_20
        maxps   xmm1, xmm0      # tmp111, vect__5.8_20
        movaps  xmm0, xmm1      # tmp112, tmp111
        shufps  xmm0, xmm1, 85  # tmp112, tmp111,
        maxps   xmm0, xmm1      # tmp109, tmp111
# find_max_8.c:13: }
        ret     
        .cfi_endproc
.LFE0:
        .size   find_max_8, .-find_max_8
        .section        .rodata.cst4,"aM",@progbits,4
        .align 4
.LC1:
        .long   -1023803392
        .ident  "GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
        .section        .note.GNU-stack,"",@progbits
