	.file	"add_arrays_restrict_size_16.c"
	.intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#	compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -ftree-vectorize
	.text
	.p2align 4
	.globl	add_delta
	.type	add_delta, @function
add_delta:
.LFB0:
	.cfi_startproc
# add_arrays_restrict_size_16.c:1: void add_delta(float *restrict a, float *restrict b) {
	xor	eax, eax	# ivtmp.17
.L2:
# add_arrays_restrict_size_16.c:5:         a[i] += b[i];
	movups	xmm0, XMMWORD PTR [rdi+rax]	# vect__7.10_26, MEM <vector(4) float> [(float *)a_11(D) + ivtmp.17_21 * 1]
	movups	xmm1, XMMWORD PTR [rsi+rax]	# tmp111, MEM <vector(4) float> [(float *)b_12(D) + ivtmp.17_21 * 1]
	addps	xmm0, xmm1	# vect__7.10_26, tmp111
	movups	XMMWORD PTR [rdi+rax], xmm0	# MEM <vector(4) float> [(float *)a_11(D) + ivtmp.17_21 * 1], vect__7.10_26
	add	rax, 16	# ivtmp.17,
	cmp	rax, 64	# ivtmp.17,
	jne	.L2	#,
# add_arrays_restrict_size_16.c:7: }
	ret	
	.cfi_endproc
.LFE0:
	.size	add_delta, .-add_delta
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
