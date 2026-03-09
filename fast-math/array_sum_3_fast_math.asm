	.file	"array_sum_3.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	sum_array
	.type	sum_array, @function
sum_array:
.LFB11:
	.cfi_startproc
	mov	eax, OFFSET FLAT:array
	mov	edx, OFFSET FLAT:array+400000
	pxor	xmm0, xmm0
	.p2align 4
	.p2align 4
	.p2align 3
.L2:
	addps	xmm0, XMMWORD PTR [rax]
	add	rax, 32
	addps	xmm0, XMMWORD PTR [rax-16]
	cmp	rdx, rax
	jne	.L2
	movaps	xmm1, xmm0
	movhlps	xmm1, xmm0
	addps	xmm1, xmm0
	movaps	xmm0, xmm1
	shufps	xmm0, xmm1, 85
	addps	xmm0, xmm1
	ret
	.cfi_endproc
.LFE11:
	.size	sum_array, .-sum_array
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"Sum: %.4f\n"
.LC5:
	.string	"Time: %.4f ms\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	push	r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pcmpeqd	xmm5, xmm5
	mov	edx, 4
	pxor	xmm3, xmm3
	push	rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movd	xmm4, edx
	psrld	xmm5, 31
	mov	ebp, OFFSET FLAT:array+400000
	push	rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	mov	ebx, OFFSET FLAT:array
	pshufd	xmm4, xmm4, 0
	mov	rax, rbx
	sub	rsp, 16
	.cfi_def_cfa_offset 48
	movdqa	xmm1, XMMWORD PTR .LC0[rip]
	.p2align 6
	.p2align 4
	.p2align 3
.L7:
	movdqa	xmm0, xmm1
	movdqa	xmm2, xmm3
	add	rax, 16
	pand	xmm0, xmm5
	psubd	xmm2, xmm1
	pcmpeqd	xmm0, xmm3
	pand	xmm2, xmm0
	pandn	xmm0, xmm1
	paddd	xmm1, xmm4
	por	xmm0, xmm2
	cvtdq2ps	xmm0, xmm0
	movaps	XMMWORD PTR [rax-16], xmm0
	cmp	rax, OFFSET FLAT:array+400000
	jne	.L7
	call	clock
	pxor	xmm0, xmm0
	mov	r12, rax
	.p2align 4
	.p2align 4
	.p2align 3
.L8:
	addps	xmm0, XMMWORD PTR [rbx]
	add	rbx, 32
	addps	xmm0, XMMWORD PTR [rbx-16]
	cmp	rbp, rbx
	jne	.L8
	movaps	XMMWORD PTR [rsp], xmm0
	call	clock
	movaps	xmm0, XMMWORD PTR [rsp]
	mov	edi, OFFSET FLAT:.LC3
	mov	rbx, rax
	mov	eax, 1
	movaps	xmm1, xmm0
	sub	rbx, r12
	movhlps	xmm1, xmm0
	addps	xmm1, xmm0
	movaps	xmm0, xmm1
	shufps	xmm0, xmm1, 85
	addps	xmm0, xmm1
	cvtss2sd	xmm0, xmm0
	call	printf
	pxor	xmm0, xmm0
	mov	edi, OFFSET FLAT:.LC5
	cvtsi2sd	xmm0, rbx
	mulsd	xmm0, QWORD PTR .LC4[rip]
	mov	eax, 1
	call	printf
	add	rsp, 16
	.cfi_def_cfa_offset 32
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.globl	array
	.bss
	.align 32
	.type	array, @object
	.size	array, 400000
array:
	.zero	400000
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC4:
	.long	-755914244
	.long	1062232653
	.ident	"GCC: (GNU) 15.2.1 20251111 (Red Hat 15.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
