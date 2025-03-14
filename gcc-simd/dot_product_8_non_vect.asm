	.file	"dot_product_8.c"
	.text
	.p2align 4
	.globl	dot_product_4
	.type	dot_product_4, @function
dot_product_4:
.LFB0:
	.cfi_startproc
	movups	(%rdi), %xmm0
	movups	(%rsi), %xmm3
	pxor	%xmm2, %xmm2
	mulps	%xmm3, %xmm0
	movaps	%xmm0, %xmm1
	addss	%xmm2, %xmm1
	movaps	%xmm0, %xmm2
	shufps	$85, %xmm0, %xmm2
	addss	%xmm2, %xmm1
	movaps	%xmm0, %xmm2
	unpckhps	%xmm0, %xmm2
	shufps	$255, %xmm0, %xmm0
	addss	%xmm1, %xmm2
	movups	16(%rdi), %xmm1
	addss	%xmm0, %xmm2
	movups	16(%rsi), %xmm0
	mulps	%xmm0, %xmm1
	movaps	%xmm1, %xmm0
	addss	%xmm2, %xmm0
	movaps	%xmm1, %xmm2
	shufps	$85, %xmm1, %xmm2
	addss	%xmm2, %xmm0
	movaps	%xmm1, %xmm2
	unpckhps	%xmm1, %xmm2
	shufps	$255, %xmm1, %xmm1
	addss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	ret
	.cfi_endproc
.LFE0:
	.size	dot_product_4, .-dot_product_4
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
