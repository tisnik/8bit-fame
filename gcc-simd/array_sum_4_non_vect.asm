	.file	"array_sum_4.c"
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
# array_sum_4.c:6:         result += a[i];
	movss	xmm0, DWORD PTR [rdi+12]	# MEM[(float *)a_8(D) + 12B], MEM[(float *)a_8(D) + 12B]
	movss	xmm1, DWORD PTR [rdi]	# *a_8(D), *a_8(D)
	addss	xmm0, DWORD PTR [rdi+4]	# _12, MEM[(float *)a_8(D) + 4B]
	addss	xmm1, DWORD PTR [rdi+8]	# _15, MEM[(float *)a_8(D) + 8B]
	addss	xmm0, xmm1	# result_9, _15
# array_sum_4.c:9: }
	ret	
	.cfi_endproc
.LFE0:
	.size	array_sum, .-array_sum
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
