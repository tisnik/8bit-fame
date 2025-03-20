	.file	"find_max_100.c"
	.intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#	compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -ftree-vectorize
	.text
	.p2align 4
	.globl	find_max_100
	.type	find_max_100, @function
find_max_100:
.LFB0:
	.cfi_startproc
# find_max_100.c:3: float find_max_100(float *a) {
	movss	xmm0, DWORD PTR .LC1[rip]	# vect__5.8,
	lea	rax, [rdi+400]	# _3,
	shufps	xmm0, xmm0, 0	# vect__5.8
	.p2align 4
	.p2align 4
	.p2align 3
.L2:
# find_max_100.c:8:         if (a[i] > max) {
	movups	xmm2, XMMWORD PTR [rdi]	# tmp115, MEM <vector(4) float> [(float *)_1]
	add	rdi, 16	# ivtmp.13,
	maxps	xmm0, xmm2	# vect__5.8, tmp115
	cmp	rax, rdi	# _3, ivtmp.13
	jne	.L2	#,
	movaps	xmm1, xmm0	# tmp108, vect__5.8
	movhlps	xmm1, xmm0	# tmp108, vect__5.8
	maxps	xmm1, xmm0	# tmp109, vect__5.8
	movaps	xmm0, xmm1	# tmp110, tmp109
	shufps	xmm0, xmm1, 85	# tmp110, tmp109,
	maxps	xmm0, xmm1	# tmp107, tmp109
# find_max_100.c:13: }
	ret	
	.cfi_endproc
.LFE0:
	.size	find_max_100, .-find_max_100
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC1:
	.long	-1023803392
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
