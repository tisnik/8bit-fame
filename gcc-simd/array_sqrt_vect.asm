	.file	"array_sqrt.c"
	.text
	.p2align 4
	.globl	array_sqrt
	.type	array_sqrt, @function
array_sqrt:
.LFB0:
	.cfi_startproc
	leaq	96(%rdi), %rax
	.p2align 5
	.p2align 4
	.p2align 3
.L2:
	movups	(%rdi), %xmm1
	addq	$16, %rdi
	sqrtps	%xmm1, %xmm0
	movups	%xmm0, -16(%rdi)
	cmpq	%rdi, %rax
	jne	.L2
	ret
	.cfi_endproc
.LFE0:
	.size	array_sqrt, .-array_sqrt
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
