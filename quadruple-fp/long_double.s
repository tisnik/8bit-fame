	.file	"long_double.c"
	.intel_syntax noprefix
	.text
	.globl	addLong
	.type	addLong, @function
addLong:
.LFB0:
	.cfi_startproc
	fld	TBYTE PTR [rsp+8]
	fld	TBYTE PTR [rsp+24]
	faddp	st(1), st
	ret
	.cfi_endproc
.LFE0:
	.size	addLong, .-addLong
	.globl	subLong
	.type	subLong, @function
subLong:
.LFB1:
	.cfi_startproc
	fld	TBYTE PTR [rsp+8]
	fld	TBYTE PTR [rsp+24]
	fsubp	st(1), st
	ret
	.cfi_endproc
.LFE1:
	.size	subLong, .-subLong
	.globl	mulLong
	.type	mulLong, @function
mulLong:
.LFB2:
	.cfi_startproc
	fld	TBYTE PTR [rsp+8]
	fld	TBYTE PTR [rsp+24]
	fmulp	st(1), st
	ret
	.cfi_endproc
.LFE2:
	.size	mulLong, .-mulLong
	.globl	divLong
	.type	divLong, @function
divLong:
.LFB3:
	.cfi_startproc
	fld	TBYTE PTR [rsp+8]
	fld	TBYTE PTR [rsp+24]
	fdivp	st(1), st
	ret
	.cfi_endproc
.LFE3:
	.size	divLong, .-divLong
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"%ld\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB4:
	.cfi_startproc
	push	rax
	.cfi_def_cfa_offset 16
	mov	esi, 16
	mov	edi, OFFSET FLAT:.LC1
	xor	eax, eax
	call	printf
	xor	eax, eax
	pop	rdx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE4:
	.size	main, .-main
	.ident	"GCC: (GNU) 15.2.1 20251111 (Red Hat 15.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
