        .file   "add_arrays_32_bytes.c"
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
        lea     rdx, [rsi+1]    # _15,
        mov     rax, rdi        # _14, a
        sub     rax, rdx        # _14, _15
        cmp     rax, 14 # _14,
        jbe     .L4     #,
# add_arrays_32_bytes.c:5:         a[i] += b[i];
        movdqu  xmm1, XMMWORD PTR [rsi] # tmp127, MEM <vector(16) unsigned char> [(unsigned char *)b_11(D)]
        movdqu  xmm0, XMMWORD PTR [rdi] # vect__6.10_6, MEM <vector(16) unsigned char> [(unsigned char *)a_10(D)]
        movdqu  xmm2, XMMWORD PTR [rdi+16]      # tmp128, MEM <vector(16) unsigned char> [(unsigned char *)a_10(D) + 16B]
        paddb   xmm0, xmm1      # vect__6.10_6, tmp127
        movups  XMMWORD PTR [rdi], xmm0 # MEM <vector(16) unsigned char> [(unsigned char *)a_10(D)], vect__6.10_6
# add_arrays_32_bytes.c:5:         a[i] += b[i];
        movdqu  xmm0, XMMWORD PTR [rsi+16]      # vect__5.9_38, MEM <vector(16) unsigned char> [(unsigned char *)b_11(D) + 16B]
# add_arrays_32_bytes.c:5:         a[i] += b[i];
        paddb   xmm0, xmm2      # vect__6.10_39, tmp128
        movups  XMMWORD PTR [rdi+16], xmm0      # MEM <vector(16) unsigned char> [(unsigned char *)a_10(D) + 16B], vect__6.10_39
        ret     
.L4:
# add_arrays_32_bytes.c:1: void add_arrays(unsigned char *a, unsigned char *b) {
        xor     eax, eax        # ivtmp.16
        .p2align 5
        .p2align 4
        .p2align 3
.L2:
# add_arrays_32_bytes.c:5:         a[i] += b[i];
        movzx   edx, BYTE PTR [rsi+rax] # MEM[(unsigned char *)b_11(D) + ivtmp.16_34 * 1], MEM[(unsigned char *)b_11(D) + ivtmp.16_34 * 1]
        add     BYTE PTR [rdi+rax], dl  # MEM[(unsigned char *)a_10(D) + ivtmp.16_34 * 1], MEM[(unsigned char *)b_11(D) + ivtmp.16_34 * 1]
# add_arrays_32_bytes.c:4:     for (i=0; i<SIZE; i++) {
        add     rax, 1  # ivtmp.16,
        cmp     rax, 32 # ivtmp.16,
        jne     .L2     #,
# add_arrays_32_bytes.c:7: }
        ret     
        .cfi_endproc
.LFE0:
        .size   add_arrays, .-add_arrays
        .ident  "GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
        .section        .note.GNU-stack,"",@progbits
