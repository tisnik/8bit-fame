	.file	"dot_product_100.c"
	.intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#	compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -ftree-vectorize
	.text
	.p2align 4
	.globl	dot_product_4
	.type	dot_product_4, @function
dot_product_4:
.LFB0:
	.cfi_startproc
# dot_product_100.c:1: float dot_product_4(float *a, float *b) {
	xor	eax, eax	# ivtmp.18
	pxor	xmm1, xmm1	# vect_result_13.12
	.p2align 5
	.p2align 4
	.p2align 3
.L2:
# dot_product_100.c:6:         result += a[i] * b[i];
	movups	xmm0, XMMWORD PTR [rdi+rax]	# vect__7.11_27, MEM <vector(4) float> [(float *)a_11(D) + ivtmp.18_23 * 1]
	movups	xmm2, XMMWORD PTR [rsi+rax]	# tmp118, MEM <vector(4) float> [(float *)b_12(D) + ivtmp.18_23 * 1]
	add	rax, 16	# ivtmp.18,
	mulps	xmm0, xmm2	# vect__7.11_27, tmp118
# dot_product_100.c:6:         result += a[i] * b[i];
	addps	xmm1, xmm0	# vect_result_13.12, vect__7.11_27
	cmp	rax, 400	# ivtmp.18,
	jne	.L2	#,
	movaps	xmm0, xmm1	# tmp110, vect_result_13.12
	movhlps	xmm0, xmm1	# tmp110, vect_result_13.12
	addps	xmm1, xmm0	# tmp111, tmp110
	movaps	xmm0, xmm1	# tmp112, tmp111
	shufps	xmm0, xmm1, 85	# tmp112, tmp111,
	addps	xmm0, xmm1	# tmp109, tmp111
# dot_product_100.c:9: }
	ret	
	.cfi_endproc
.LFE0:
	.size	dot_product_4, .-dot_product_4
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
