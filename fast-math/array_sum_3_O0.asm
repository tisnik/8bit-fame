	.file	"array_sum_3.c"
	.intel_syntax noprefix
	.text
	.globl	array
	.bss
	.align 32
	.type	array, @object
	.size	array, 400000
array:
	.zero	400000
	.text
	.globl	sum_array
	.type	sum_array, @function
sum_array:
.LFB0:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	pxor	xmm0, xmm0
	movss	DWORD PTR [rbp-4], xmm0
	mov	DWORD PTR [rbp-8], 0
	jmp	.L2
.L3:
	mov	eax, DWORD PTR [rbp-8]
	cdqe
	movss	xmm0, DWORD PTR array[0+rax*4]
	movss	xmm1, DWORD PTR [rbp-4]
	addss	xmm0, xmm1
	movss	DWORD PTR [rbp-4], xmm0
	add	DWORD PTR [rbp-8], 1
.L2:
	cmp	DWORD PTR [rbp-8], 99999
	jle	.L3
	movss	xmm0, DWORD PTR [rbp-4]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	sum_array, .-sum_array
	.section	.rodata
.LC1:
	.string	"Sum: %.4f\n"
.LC4:
	.string	"Time: %.4f ms\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	DWORD PTR [rbp-4], 0
	jmp	.L6
.L9:
	mov	eax, DWORD PTR [rbp-4]
	and	eax, 1
	test	eax, eax
	jne	.L7
	mov	eax, DWORD PTR [rbp-4]
	neg	eax
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, eax
	jmp	.L8
.L7:
	pxor	xmm0, xmm0
	cvtsi2ss	xmm0, DWORD PTR [rbp-4]
.L8:
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	movss	DWORD PTR array[0+rax*4], xmm0
	add	DWORD PTR [rbp-4], 1
.L6:
	cmp	DWORD PTR [rbp-4], 99999
	jle	.L9
	call	clock
	mov	QWORD PTR [rbp-16], rax
	call	sum_array
	movd	eax, xmm0
	mov	DWORD PTR [rbp-20], eax
	call	clock
	mov	QWORD PTR [rbp-32], rax
	pxor	xmm3, xmm3
	cvtss2sd	xmm3, DWORD PTR [rbp-20]
	movq	rax, xmm3
	movq	xmm0, rax
	mov	edi, OFFSET FLAT:.LC1
	mov	eax, 1
	call	printf
	mov	rax, QWORD PTR [rbp-32]
	sub	rax, QWORD PTR [rbp-16]
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	movsd	xmm2, QWORD PTR .LC2[rip]
	movapd	xmm1, xmm0
	divsd	xmm1, xmm2
	movsd	xmm0, QWORD PTR .LC3[rip]
	mulsd	xmm1, xmm0
	movq	rax, xmm1
	movq	xmm0, rax
	mov	edi, OFFSET FLAT:.LC4
	mov	eax, 1
	call	printf
	mov	eax, 0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC2:
	.long	0
	.long	1093567616
	.align 8
.LC3:
	.long	0
	.long	1083129856
	.ident	"GCC: (GNU) 15.2.1 20251111 (Red Hat 15.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
