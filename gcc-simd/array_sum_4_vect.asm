	.file	"array_sum_4.c"
	.intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#	compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -ftree-vectorize
	.text
	.p2align 4
	.globl	array_sum
	.type	array_sum, @function
array_sum:
.LFB0:
	.cfi_startproc
# array_sum_4.c:6:         result += a[i];
	movups	xmm0, XMMWORD PTR [rdi]	# vect__4.7_19, MEM <vector(4) float> [(float *)a_8(D)]
	movaps	xmm1, xmm0	# tmp103, vect__4.7_19
	movhlps	xmm1, xmm0	# tmp103, vect__4.7_19
	addps	xmm1, xmm0	# tmp104, vect__4.7_19
	movaps	xmm0, xmm1	# tmp105, tmp104
	shufps	xmm0, xmm1, 85	# tmp105, tmp104,
	addps	xmm0, xmm1	# tmp102, tmp104
# array_sum_4.c:9: }
	ret	
	.cfi_endproc
.LFE0:
	.size	array_sum, .-array_sum
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
