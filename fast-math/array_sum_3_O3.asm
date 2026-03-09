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
	pxor	xmm0, xmm0
	.p2align 5
	.p2align 4
	.p2align 3
.L2:
	addss	xmm0, DWORD PTR [rax]
	add	rax, 16
	addss	xmm0, DWORD PTR [rax-12]
	addss	xmm0, DWORD PTR [rax-8]
	addss	xmm0, DWORD PTR [rax-4]
	cmp	rax, OFFSET FLAT:array+400000
	jne	.L2
	ret
	.cfi_endproc
.LFE11:
	.size	sum_array, .-sum_array
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC4:
	.string	"Sum: %.4f\n"
.LC7:
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
	mov	ebp, OFFSET FLAT:array
	movd	xmm4, edx
	mov	r12d, OFFSET FLAT:array+400000
	push	rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	mov	rax, rbp
	psrld	xmm5, 31
	pshufd	xmm4, xmm4, 0
	sub	rsp, 16
	.cfi_def_cfa_offset 48
	movdqa	xmm1, XMMWORD PTR .LC1[rip]
	.p2align 6
	.p2align 4
	.p2align 3
.L6:
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
	jne	.L6
	call	clock
	pxor	xmm0, xmm0
	mov	rbx, rax
	.p2align 5
	.p2align 4
	.p2align 3
.L7:
	addss	xmm0, DWORD PTR [rbp+0]
	add	rbp, 16
	addss	xmm0, DWORD PTR [rbp-12]
	addss	xmm0, DWORD PTR [rbp-8]
	addss	xmm0, DWORD PTR [rbp-4]
	cmp	r12, rbp
	jne	.L7
	movss	DWORD PTR [rsp+12], xmm0
	call	clock
	mov	edi, OFFSET FLAT:.LC4
	pxor	xmm0, xmm0
	mov	rbp, rax
	mov	eax, 1
	cvtss2sd	xmm0, DWORD PTR [rsp+12]
	call	printf
	sub	rbp, rbx
	pxor	xmm0, xmm0
	mov	edi, OFFSET FLAT:.LC7
	cvtsi2sd	xmm0, rbp
	divsd	xmm0, QWORD PTR .LC5[rip]
	mov	eax, 1
	mulsd	xmm0, QWORD PTR .LC6[rip]
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
.LC1:
	.long	0
	.long	1
	.long	2
	.long	3
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC5:
	.long	0
	.long	1093567616
	.align 8
.LC6:
	.long	0
	.long	1083129856
	.ident	"GCC: (GNU) 15.2.1 20251111 (Red Hat 15.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
