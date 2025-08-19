        .file   "find_max_8.c"
        .intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#       compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -fno-tree-vectorize
        .text
        .p2align 4
        .globl  find_max_8
        .type   find_max_8, @function
find_max_8:
.LFB0:
        .cfi_startproc
# find_max_8.c:6:     float max = FLT_MIN_EXP;
        movss   xmm0, DWORD PTR .LC0[rip]       # <retval>,
        lea     rax, [rdi+32]   # _19,
.L2:
# find_max_8.c:8:         if (a[i] > max) {
        maxss   xmm0, DWORD PTR [rdi]   # <retval>, MEM[(float *)_17]
# find_max_8.c:7:     for (i=0; i<SIZE; i++) {
        add     rdi, 8  # ivtmp.10,
# find_max_8.c:8:         if (a[i] > max) {
        maxss   xmm0, DWORD PTR [rdi-4] # <retval>, MEM[(float *)_17]
# find_max_8.c:7:     for (i=0; i<SIZE; i++) {
        cmp     rdi, rax        # ivtmp.10, _19
        jne     .L2     #,
# find_max_8.c:13: }
        ret     
        .cfi_endproc
.LFE0:
        .size   find_max_8, .-find_max_8
        .section        .rodata.cst4,"aM",@progbits,4
        .align 4
.LC0:
        .long   -1023803392
        .ident  "GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
        .section        .note.GNU-stack,"",@progbits
