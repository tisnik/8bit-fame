	.file	"array_sum_8.c"
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
# array_sum_8.c:6:         result += a[i];
	movups	xmm1, XMMWORD PTR [rdi+16]	# vect__4.7_19, MEM <vector(4) float> [(float *)a_8(D) + 16B]
	movups	xmm0, XMMWORD PTR [rdi]	# vect__4.7_1, MEM <vector(4) float> [(float *)a_8(D)]
# array_sum_8.c:6:         result += a[i];
	addps	xmm0, xmm1	# vect_result_9.8_20, vect__4.7_19
	movaps	xmm1, xmm0	# tmp107, vect_result_9.8_20
	movhlps	xmm1, xmm0	# tmp107, vect_result_9.8_20
	addps	xmm1, xmm0	# tmp108, vect_result_9.8_20
	movaps	xmm0, xmm1	# tmp109, tmp108
	shufps	xmm0, xmm1, 85	# tmp109, tmp108,
	addps	xmm0, xmm1	# tmp106, tmp108
# array_sum_8.c:9: }
	ret	
	.cfi_endproc
.LFE0:
	.size	array_sum, .-array_sum
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
