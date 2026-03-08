	.file	"nan_test.c"
	.intel_syntax noprefix
	.text
	.globl	nan_test
	.type	nan_test, @function
nan_test:
.LFB0:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	movss	DWORD PTR [rbp-4], xmm0
	movss	xmm0, DWORD PTR [rbp-4]
	ucomiss	xmm0, DWORD PTR [rbp-4]
	setp	al
	movzx	eax, al
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	nan_test, .-nan_test
	.ident	"GCC: (GNU) 15.2.1 20251111 (Red Hat 15.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
