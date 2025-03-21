	.file	"add_arrays_size_16_backward.c"
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
	mov	rax, rdi	# _16, a
	sub	rax, rsi	# _16, b
	add	rax, 12	# _8,
	cmp	rax, 8	# _8,
	jbe	.L5	#,
# add_arrays_size_16_backward.c:1: void add_delta(float *a, float *b) {
	mov	eax, 48	# ivtmp.41,
.L3:
# add_arrays_size_16_backward.c:5:         a[i] += b[i];
	movups	xmm0, XMMWORD PTR [rdi+rax]	# MEM <vector(4) float> [(float *)a_11(D) + ivtmp.41_1 * 1], MEM <vector(4) float> [(float *)a_11(D) + ivtmp.41_1 * 1]
# add_arrays_size_16_backward.c:5:         a[i] += b[i];
	movups	xmm1, XMMWORD PTR [rsi+rax]	# MEM <vector(4) float> [(float *)b_12(D) + ivtmp.41_1 * 1], MEM <vector(4) float> [(float *)b_12(D) + ivtmp.41_1 * 1]
# add_arrays_size_16_backward.c:5:         a[i] += b[i];
	shufps	xmm0, xmm0, 27	# vect__4.7_43, MEM <vector(4) float> [(float *)a_11(D) + ivtmp.41_1 * 1],
# add_arrays_size_16_backward.c:5:         a[i] += b[i];
	shufps	xmm1, xmm1, 27	# vect__6.11_48, MEM <vector(4) float> [(float *)b_12(D) + ivtmp.41_1 * 1],
# add_arrays_size_16_backward.c:5:         a[i] += b[i];
	addps	xmm0, xmm1	# vect__7.12, vect__6.11_48
	shufps	xmm0, xmm0, 27	# vect__7.15_53, vect__7.12,
	movups	XMMWORD PTR [rdi+rax], xmm0	# MEM <vector(4) float> [(float *)a_11(D) + ivtmp.41_1 * 1], vect__7.15_53
	sub	rax, 16	# ivtmp.41,
	cmp	rax, -16	# ivtmp.41,
	jne	.L3	#,
	ret	
	.p2align 4,,10
	.p2align 3
.L5:
# add_arrays_size_16_backward.c:1: void add_delta(float *a, float *b) {
	mov	eax, 60	# ivtmp.29,
	.p2align 5
	.p2align 4
	.p2align 3
.L2:
# add_arrays_size_16_backward.c:5:         a[i] += b[i];
	movss	xmm0, DWORD PTR [rdi+rax]	# MEM[(float *)a_11(D) + ivtmp.29_17 * 1], MEM[(float *)a_11(D) + ivtmp.29_17 * 1]
	addss	xmm0, DWORD PTR [rsi+rax]	# _34, MEM[(float *)b_12(D) + ivtmp.29_17 * 1]
	movss	DWORD PTR [rdi+rax], xmm0	# MEM[(float *)a_11(D) + ivtmp.29_17 * 1], _34
# add_arrays_size_16_backward.c:4:     for (i=SIZE-1; i>=0; i--) {
	sub	rax, 4	# ivtmp.29,
	cmp	rax, -4	# ivtmp.29,
	jne	.L2	#,
# add_arrays_size_16_backward.c:7: }
	ret	
	.cfi_endproc
.LFE0:
	.size	add_delta, .-add_delta
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
