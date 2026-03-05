	.file	"sin.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"Sum:  %.4f\n"
.LC4:
	.string	"Time: %.4f ms\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB11:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	push	rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	xor	ebx, ebx
	sub	rsp, 56
	.cfi_def_cfa_offset 80
	call	clock
	pxor	xmm6, xmm6
	movdqa	xmm2, XMMWORD PTR .LC0[rip]
	mov	rbp, rax
	mov	eax, 4
	movaps	XMMWORD PTR [rsp], xmm6
	movd	xmm6, eax
	pshufd	xmm7, xmm6, 0
	movaps	XMMWORD PTR [rsp+32], xmm7
	.p2align 4
	.p2align 3
.L2:
	pshufd	xmm1, xmm2, 238
	cvtdq2pd	xmm0, xmm2
	movaps	XMMWORD PTR [rsp+16], xmm2
	add	ebx, 1
	mulpd	xmm0, XMMWORD PTR .LC5[rip]
	cvtdq2pd	xmm1, xmm1
	mulpd	xmm1, XMMWORD PTR .LC5[rip]
	cvtpd2ps	xmm0, xmm0
	cvtpd2ps	xmm1, xmm1
	movlhps	xmm0, xmm1
	call	_ZGVbN4v_sinf
	addps	xmm0, XMMWORD PTR [rsp]
	movdqa	xmm2, XMMWORD PTR [rsp+16]
	paddd	xmm2, XMMWORD PTR [rsp+32]
	movaps	XMMWORD PTR [rsp], xmm0
	cmp	ebx, 249999
	jne	.L2
	call	clock
	movaps	xmm5, XMMWORD PTR [rsp]
	mov	edi, OFFSET FLAT:.LC2
	mov	rbx, rax
	mov	eax, 1
	movaps	xmm1, xmm5
	sub	rbx, rbp
	movhlps	xmm1, xmm5
	addps	xmm1, xmm5
	movaps	xmm0, xmm1
	shufps	xmm0, xmm1, 85
	addps	xmm0, xmm1
	subss	xmm0, DWORD PTR .LC1[rip]
	cvtss2sd	xmm0, xmm0
	call	printf
	pxor	xmm0, xmm0
	mov	edi, OFFSET FLAT:.LC4
	cvtsi2sd	xmm0, rbx
	mulsd	xmm0, QWORD PTR .LC3[rip]
	mov	eax, 1
	call	printf
	add	rsp, 56
	.cfi_def_cfa_offset 24
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE11:
	.size	main, .-main
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	1
	.long	2
	.long	3
	.long	4
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC1:
	.long	941608137
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC3:
	.long	-755914244
	.long	1062232653
	.section	.rodata.cst16
	.align 16
.LC5:
	.long	-746556291
	.long	1054497412
	.long	-746556291
	.long	1054497412
	.ident	"GCC: (GNU) 15.2.1 20251111 (Red Hat 15.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
