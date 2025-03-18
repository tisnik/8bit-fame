	.file	"array_sum_4.c"
	.text
	.p2align 4
	.globl	array_sum
	.type	array_sum, @function
array_sum:
.LFB0:
	.cfi_startproc
	pxor	%xmm0, %xmm0
	addss	(%rdi), %xmm0
	addss	4(%rdi), %xmm0
	addss	8(%rdi), %xmm0
	addss	12(%rdi), %xmm0
	ret
	.cfi_endproc
.LFE0:
	.size	array_sum, .-array_sum
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
