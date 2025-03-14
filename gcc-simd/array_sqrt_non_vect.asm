	.file	"array_sqrt.c"
	.intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#	compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -fno-tree-vectorize
	.text
	.p2align 4
	.globl	array_sqrt
	.type	array_sqrt, @function
array_sqrt:
.LFB0:
	.cfi_startproc
	lea	rax, [rdi+96]	# _21,
	.p2align 5
	.p2align 4
	.p2align 3
.L2:
# array_sqrt.c:7:         a[i] = sqrt(a[i]);
	movss	xmm0, DWORD PTR [rdi]	# _5, MEM[(float *)_18]
# array_sqrt.c:6:     for (i=0; i<SIZE; i++) {
	add	rdi, 4	# ivtmp.10,
# array_sqrt.c:7:         a[i] = sqrt(a[i]);
	sqrtss	xmm0, xmm0	# _5, _5
# array_sqrt.c:7:         a[i] = sqrt(a[i]);
	movss	DWORD PTR [rdi-4], xmm0	# MEM[(float *)_18], _5
# array_sqrt.c:6:     for (i=0; i<SIZE; i++) {
	cmp	rdi, rax	# ivtmp.10, _21
	jne	.L2	#,
# array_sqrt.c:9: }
	ret	
	.cfi_endproc
.LFE0:
	.size	array_sqrt, .-array_sqrt
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
