	.file	"find_max_4.c"
	.intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#	compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -ftree-vectorize
	.text
	.p2align 4
	.globl	find_max_4
	.type	find_max_4, @function
find_max_4:
.LFB0:
	.cfi_startproc
# find_max_4.c:8:         if (a[i] > max) {
	movups	xmm0, XMMWORD PTR [rdi]	# vect__4.7_19, MEM <vector(4) float> [(float *)a_9(D)]
	movaps	xmm1, xmm0	# tmp104, vect__4.7_19
	movhlps	xmm1, xmm0	# tmp104, vect__4.7_19
	maxps	xmm1, xmm0	# tmp105, vect__4.7_19
	movaps	xmm0, xmm1	# tmp106, tmp105
	shufps	xmm0, xmm1, 85	# tmp106, tmp105,
	maxps	xmm0, xmm1	# tmp103, tmp105
# find_max_4.c:12:     return max;
	maxss	xmm0, DWORD PTR .LC0[rip]	# _22,
# find_max_4.c:13: }
	ret	
	.cfi_endproc
.LFE0:
	.size	find_max_4, .-find_max_4
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC0:
	.long	-1023803392
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
