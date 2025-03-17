	.file	"add_arrays_size_17.c"
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
	lea	rdx, [rsi+4]	# _8,
	mov	rax, rdi	# _23, a
	sub	rax, rdx	# _23, _8
	cmp	rax, 8	# _23,
# add_arrays_size_17.c:1: void add_delta(float *a, float *b) {
	mov	eax, 0	# ivtmp.25,
	jbe	.L2	#,
.L3:
# add_arrays_size_17.c:5:         a[i] += b[i];
	movups	xmm0, XMMWORD PTR [rdi+rax]	# vect__7.12_61, MEM <vector(4) float> [(float *)a_11(D) + ivtmp.30_50 * 1]
	movups	xmm1, XMMWORD PTR [rsi+rax]	# tmp128, MEM <vector(4) float> [(float *)b_12(D) + ivtmp.30_50 * 1]
	addps	xmm0, xmm1	# vect__7.12_61, tmp128
	movups	XMMWORD PTR [rdi+rax], xmm0	# MEM <vector(4) float> [(float *)a_11(D) + ivtmp.30_50 * 1], vect__7.12_61
	add	rax, 16	# ivtmp.30,
	cmp	rax, 64	# ivtmp.30,
	jne	.L3	#,
	movss	xmm0, DWORD PTR [rdi+64]	# MEM[(float *)a_11(D) + 64B], MEM[(float *)a_11(D) + 64B]
	addss	xmm0, DWORD PTR [rsi+64]	# _48, MEM[(float *)b_12(D) + 64B]
	movss	DWORD PTR [rdi+64], xmm0	# MEM[(float *)a_11(D) + 64B], _48
	ret	
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L2:
	movss	xmm0, DWORD PTR [rdi+rax]	# MEM[(float *)a_11(D) + ivtmp.25_43 * 1], MEM[(float *)a_11(D) + ivtmp.25_43 * 1]
	addss	xmm0, DWORD PTR [rsi+rax]	# _34, MEM[(float *)b_12(D) + ivtmp.25_43 * 1]
	movss	DWORD PTR [rdi+rax], xmm0	# MEM[(float *)a_11(D) + ivtmp.25_43 * 1], _34
# add_arrays_size_17.c:4:     for (i=0; i<SIZE; i++) {
	add	rax, 4	# ivtmp.25,
	cmp	rax, 68	# ivtmp.25,
	jne	.L2	#,
# add_arrays_size_17.c:7: }
	ret	
	.cfi_endproc
.LFE0:
	.size	add_delta, .-add_delta
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
