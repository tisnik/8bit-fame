	.file	"array_clear_size_8.c"
	.intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#	compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -masm=intel -mtune=generic -march=x86-64
	.text
	.globl	clear
	.type	clear, @function
clear:
.LFB0:
	.cfi_startproc
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi	# a, a
# array_clear_size_8.c:4:     for (i=0; i<SIZE; i++) {
	mov	DWORD PTR [rbp-4], 0	# i,
# array_clear_size_8.c:4:     for (i=0; i<SIZE; i++) {
	jmp	.L2	#
.L3:
# array_clear_size_8.c:5:         a[i] = 0.0;
	mov	eax, DWORD PTR [rbp-4]	# tmp101, i
	cdqe
	lea	rdx, [0+rax*4]	# _2,
	mov	rax, QWORD PTR [rbp-24]	# tmp102, a
	add	rax, rdx	# _3, _2
# array_clear_size_8.c:5:         a[i] = 0.0;
	pxor	xmm0, xmm0	# tmp103
	movss	DWORD PTR [rax], xmm0	# *_3, tmp103
# array_clear_size_8.c:4:     for (i=0; i<SIZE; i++) {
	add	DWORD PTR [rbp-4], 1	# i,
.L2:
# array_clear_size_8.c:4:     for (i=0; i<SIZE; i++) {
	cmp	DWORD PTR [rbp-4], 7	# i,
	jle	.L3	#,
# array_clear_size_8.c:7: }
	nop	
	nop	
	pop	rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE0:
	.size	clear, .-clear
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
