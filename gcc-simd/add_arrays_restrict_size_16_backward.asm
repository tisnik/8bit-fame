        .file   "add_arrays_restrict_size_16_backward.c"
        .intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#       compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -ftree-vectorize
        .text
        .p2align 4
        .globl  add_arrays
        .type   add_arrays, @function
add_arrays:
.LFB0:
        .cfi_startproc
# add_arrays_restrict_size_16_backward.c:1: void add_arrays(float *restrict a, float *restrict b) {
        mov     eax, 48 # ivtmp.27,
.L2:
# add_arrays_restrict_size_16_backward.c:5:         a[i] += b[i];
        movups  xmm0, XMMWORD PTR [rdi+rax]     # MEM <vector(4) float> [(float *)a_11(D) + ivtmp.27_23 * 1], MEM <vector(4) float> [(float *)a_11(D) + ivtmp.27_23 * 1]
# add_arrays_restrict_size_16_backward.c:5:         a[i] += b[i];
        movups  xmm1, XMMWORD PTR [rsi+rax]     # MEM <vector(4) float> [(float *)b_12(D) + ivtmp.27_23 * 1], MEM <vector(4) float> [(float *)b_12(D) + ivtmp.27_23 * 1]
# add_arrays_restrict_size_16_backward.c:5:         a[i] += b[i];
        shufps  xmm0, xmm0, 27  # vect__4.7_8, MEM <vector(4) float> [(float *)a_11(D) + ivtmp.27_23 * 1],
# add_arrays_restrict_size_16_backward.c:5:         a[i] += b[i];
        shufps  xmm1, xmm1, 27  # vect__6.11_29, MEM <vector(4) float> [(float *)b_12(D) + ivtmp.27_23 * 1],
# add_arrays_restrict_size_16_backward.c:5:         a[i] += b[i];
        addps   xmm0, xmm1      # vect__7.12, vect__6.11_29
        shufps  xmm0, xmm0, 27  # vect__7.15_34, vect__7.12,
        movups  XMMWORD PTR [rdi+rax], xmm0     # MEM <vector(4) float> [(float *)a_11(D) + ivtmp.27_23 * 1], vect__7.15_34
        sub     rax, 16 # ivtmp.27,
        cmp     rax, -16        # ivtmp.27,
        jne     .L2     #,
# add_arrays_restrict_size_16_backward.c:7: }
        ret     
        .cfi_endproc
.LFE0:
        .size   add_arrays, .-add_arrays
        .ident  "GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
        .section        .note.GNU-stack,"",@progbits
