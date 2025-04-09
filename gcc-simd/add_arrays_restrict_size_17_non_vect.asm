        .file   "add_arrays_restrict_size_17.c"
        .intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#       compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -fno-tree-vectorize
        .text
        .p2align 4
        .globl  add_delta
        .type   add_delta, @function
add_delta:
.LFB0:
        .cfi_startproc
# add_arrays_restrict_size_17.c:1: void add_delta(float *restrict a, float *restrict b) {
        xor     eax, eax        # ivtmp.12
        .p2align 5
        .p2align 4
        .p2align 3
.L2:
# add_arrays_restrict_size_17.c:5:         a[i] += b[i];
        movss   xmm0, DWORD PTR [rdi+rax]       # MEM[(float *)a_11(D) + ivtmp.12_19 * 1], MEM[(float *)a_11(D) + ivtmp.12_19 * 1]
        addss   xmm0, DWORD PTR [rsi+rax]       # _7, MEM[(float *)b_12(D) + ivtmp.12_19 * 1]
        movss   DWORD PTR [rdi+rax], xmm0       # MEM[(float *)a_11(D) + ivtmp.12_19 * 1], _7
# add_arrays_restrict_size_17.c:4:     for (i=0; i<SIZE; i++) {
        add     rax, 4  # ivtmp.12,
        cmp     rax, 68 # ivtmp.12,
        jne     .L2     #,
# add_arrays_restrict_size_17.c:7: }
        ret     
        .cfi_endproc
.LFE0:
        .size   add_delta, .-add_delta
        .ident  "GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
        .section        .note.GNU-stack,"",@progbits
