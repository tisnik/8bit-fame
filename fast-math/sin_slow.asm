	.file	"sin.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"Sum:  %.4f\n"
.LC5:
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
	mov	ebx, 1
	sub	rsp, 24
	.cfi_def_cfa_offset 48
	call	clock
	mov	DWORD PTR [rsp+12], 0x00000000
	mov	rbp, rax
	.p2align 4
	.p2align 3
.L2:
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, ebx
	mulsd	xmm0, QWORD PTR .LC1[rip]
	add	ebx, 1
	divsd	xmm0, QWORD PTR .LC2[rip]
	cvtsd2ss	xmm0, xmm0
	call	sinf
	addss	xmm0, DWORD PTR [rsp+12]
	movss	DWORD PTR [rsp+12], xmm0
	cmp	ebx, 1000000
	jne	.L2
	call	clock
	mov	edi, OFFSET FLAT:.LC3
	pxor	xmm0, xmm0
	mov	rbx, rax
	mov	eax, 1
	cvtss2sd	xmm0, DWORD PTR [rsp+12]
	call	printf
	sub	rbx, rbp
	pxor	xmm0, xmm0
	mov	edi, OFFSET FLAT:.LC5
	cvtsi2sd	xmm0, rbx
	divsd	xmm0, QWORD PTR .LC2[rip]
	mov	eax, 1
	mulsd	xmm0, QWORD PTR .LC4[rip]
	call	printf
	add	rsp, 24
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
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	1413754136
	.long	1075388923
	.align 8
.LC2:
	.long	0
	.long	1093567616
	.align 8
.LC4:
	.long	0
	.long	1083129856
	.ident	"GCC: (GNU) 15.2.1 20251111 (Red Hat 15.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
