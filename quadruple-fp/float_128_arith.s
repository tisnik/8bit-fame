	.file	"arith.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	add128
	.type	add128, @function
add128:
.LFB25:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	call	__addtf3
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE25:
	.size	add128, .-add128
	.p2align 4
	.globl	sub128
	.type	sub128, @function
sub128:
.LFB26:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	call	__subtf3
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE26:
	.size	sub128, .-sub128
	.p2align 4
	.globl	mul128
	.type	mul128, @function
mul128:
.LFB27:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	call	__multf3
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE27:
	.size	mul128, .-mul128
	.p2align 4
	.globl	div128
	.type	div128, @function
div128:
.LFB28:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	call	__divtf3
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE28:
	.size	div128, .-div128
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%.*Qf"
	.text
	.p2align 4
	.globl	print_float128
	.type	print_float128, @function
print_float128:
.LFB29:
	.cfi_startproc
	sub	rsp, 120
	.cfi_def_cfa_offset 128
	mov	ecx, 90
	mov	edx, OFFSET FLAT:.LC0
	mov	esi, 100
	mov	rdi, rsp
	mov	eax, 1
	call	quadmath_snprintf
	mov	rdi, rsp
	call	puts
	add	rsp, 120
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE29:
	.size	print_float128, .-print_float128
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB30:
	.cfi_startproc
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	movdqa	xmm0, XMMWORD PTR .LC1[rip]
	call	print_float128
	movdqa	xmm0, XMMWORD PTR .LC2[rip]
	call	print_float128
	movdqa	xmm0, XMMWORD PTR .LC3[rip]
	call	print_float128
	movdqa	xmm0, XMMWORD PTR .LC4[rip]
	call	print_float128
	xor	eax, eax
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE30:
	.size	main, .-main
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC1:
	.long	0
	.long	0
	.long	0
	.long	1073676288
	.align 16
.LC2:
	.long	1431655765
	.long	1431655765
	.long	1431655765
	.long	-1073916587
	.align 16
.LC3:
	.long	477218588
	.long	-954437177
	.long	1908874353
	.long	1073530652
	.align 16
.LC4:
	.long	0
	.long	0
	.long	0
	.long	1073610752
	.globl	__divtf3
	.globl	__multf3
	.globl	__subtf3
	.globl	__addtf3
	.ident	"GCC: (GNU) 15.2.1 20251111 (Red Hat 15.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
