	.file	"add_arrays_size_4.c"
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
	jbe	.L4	#,
# add_arrays_size_4.c:5:         a[i] += b[i];
	movups	xmm0, XMMWORD PTR [rsi]	# vect__6.9_42, MEM <vector(4) float> [(float *)b_12(D)]
# add_arrays_size_4.c:5:         a[i] += b[i];
	movups	xmm1, XMMWORD PTR [rdi]	# tmp121, MEM <vector(4) float> [(float *)a_11(D)]
	addps	xmm0, xmm1	# vect__7.10_43, tmp121
	movups	XMMWORD PTR [rdi], xmm0	# MEM <vector(4) float> [(float *)a_11(D)], vect__7.10_43
	ret	
	.p2align 4,,10
	.p2align 3
.L4:
# add_arrays_size_4.c:1: void add_delta(float *a, float *b) {
	xor	eax, eax	# ivtmp.23
.L2:
# add_arrays_size_4.c:5:         a[i] += b[i];
	movss	xmm0, DWORD PTR [rdi+rax]	# MEM[(float *)a_11(D) + ivtmp.23_41 * 1], MEM[(float *)a_11(D) + ivtmp.23_41 * 1]
	addss	xmm0, DWORD PTR [rsi+rax]	# _32, MEM[(float *)b_12(D) + ivtmp.23_41 * 1]
	movss	DWORD PTR [rdi+rax], xmm0	# MEM[(float *)a_11(D) + ivtmp.23_41 * 1], _32
# add_arrays_size_4.c:4:     for (i=0; i<SIZE; i++) {
	add	rax, 4	# ivtmp.23,
	cmp	rax, 16	# ivtmp.23,
	jne	.L2	#,
# add_arrays_size_4.c:7: }
	ret	
	.cfi_endproc
.LFE0:
	.size	add_delta, .-add_delta
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
