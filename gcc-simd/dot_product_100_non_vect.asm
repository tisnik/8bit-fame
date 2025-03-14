	.file	"dot_product_100.c"
	.text
	.p2align 4
	.globl	dot_product_4
	.type	dot_product_4, @function
dot_product_4:
.LFB0:
	.cfi_startproc
	xorl	%eax, %eax
	pxor	%xmm0, %xmm0
	.p2align 6
	.p2align 4
	.p2align 3
.L2:
	movups	(%rdi,%rax), %xmm1
	movups	(%rsi,%rax), %xmm3
	addq	$16, %rax
	mulps	%xmm3, %xmm1
	addss	%xmm1, %xmm0
	movaps	%xmm1, %xmm2
	shufps	$85, %xmm1, %xmm2
	addss	%xmm2, %xmm0
	movaps	%xmm1, %xmm2
	unpckhps	%xmm1, %xmm2
	shufps	$255, %xmm1, %xmm1
	addss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	cmpq	$400, %rax
	jne	.L2
	ret
	.cfi_endproc
.LFE0:
	.size	dot_product_4, .-dot_product_4
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
