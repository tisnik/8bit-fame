	.file	"array_sum_8.c"
	.intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#	compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -fno-tree-vectorize
	.text
	.p2align 4
	.globl	array_sum
	.type	array_sum, @function
array_sum:
.LFB0:
	.cfi_startproc
	lea	rax, [rdi+32]	# _19,
# array_sum_8.c:4:     float result = 0.0;
	pxor	xmm0, xmm0	# <retval>
.L2:
# array_sum_8.c:6:         result += a[i];
	addss	xmm0, DWORD PTR [rdi]	# <retval>, MEM[(float *)_17]
# array_sum_8.c:5:     for (i=0; i<SIZE; i++) {
	add	rdi, 8	# ivtmp.10,
# array_sum_8.c:6:         result += a[i];
	addss	xmm0, DWORD PTR [rdi-4]	# <retval>, MEM[(float *)_17]
# array_sum_8.c:5:     for (i=0; i<SIZE; i++) {
	cmp	rdi, rax	# ivtmp.10, _19
	jne	.L2	#,
# array_sum_8.c:9: }
	ret	
	.cfi_endproc
.LFE0:
	.size	array_sum, .-array_sum
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
