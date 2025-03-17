	.file	"add_arrays_size_16.c"
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
	lea	rdx, [rsi+4]	# _15,
	mov	rax, rdi	# _9, a
	sub	rax, rdx	# _9, _15
	cmp	rax, 8	# _9,
# add_arrays_size_16.c:1: void add_delta(float *a, float *b) {
	mov	eax, 0	# ivtmp.22,
	jbe	.L2	#,
.L3:
# add_arrays_size_16.c:5:         a[i] += b[i];
	movups	xmm0, XMMWORD PTR [rdi+rax]	# vect__7.10_43, MEM <vector(4) float> [(float *)a_11(D) + ivtmp.27_1 * 1]
	movups	xmm1, XMMWORD PTR [rsi+rax]	# tmp123, MEM <vector(4) float> [(float *)b_12(D) + ivtmp.27_1 * 1]
	addps	xmm0, xmm1	# vect__7.10_43, tmp123
	movups	XMMWORD PTR [rdi+rax], xmm0	# MEM <vector(4) float> [(float *)a_11(D) + ivtmp.27_1 * 1], vect__7.10_43
	add	rax, 16	# ivtmp.27,
	cmp	rax, 64	# ivtmp.27,
	jne	.L3	#,
	ret	
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L2:
	movss	xmm0, DWORD PTR [rdi+rax]	# MEM[(float *)a_11(D) + ivtmp.22_17 * 1], MEM[(float *)a_11(D) + ivtmp.22_17 * 1]
	addss	xmm0, DWORD PTR [rsi+rax]	# _32, MEM[(float *)b_12(D) + ivtmp.22_17 * 1]
	movss	DWORD PTR [rdi+rax], xmm0	# MEM[(float *)a_11(D) + ivtmp.22_17 * 1], _32
# add_arrays_size_16.c:4:     for (i=0; i<SIZE; i++) {
	add	rax, 4	# ivtmp.22,
	cmp	rax, 64	# ivtmp.22,
	jne	.L2	#,
# add_arrays_size_16.c:7: }
	ret	
	.cfi_endproc
.LFE0:
	.size	add_delta, .-add_delta
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
