	.file	"add_delta_size_16.c"
	.intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#	compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -fno-tree-vectorize
	.text
	.p2align 4
	.globl	add_delta
	.type	add_delta, @function
add_delta:
.LFB0:
	.cfi_startproc
	lea	rax, [rdi+64]	# _22,
	.p2align 5
	.p2align 4
	.p2align 3
.L2:
# add_delta_size_16.c:5:         a[i] += delta;
	movss	xmm1, DWORD PTR [rdi]	# _5, MEM[(float *)_19]
# add_delta_size_16.c:4:     for (i=0; i<SIZE; i++) {
	add	rdi, 4	# ivtmp.10,
# add_delta_size_16.c:5:         a[i] += delta;
	addss	xmm1, xmm0	# _5, delta
	movss	DWORD PTR [rdi-4], xmm1	# MEM[(float *)_19], _5
# add_delta_size_16.c:4:     for (i=0; i<SIZE; i++) {
	cmp	rdi, rax	# ivtmp.10, _22
	jne	.L2	#,
# add_delta_size_16.c:7: }
	ret	
	.cfi_endproc
.LFE0:
	.size	add_delta, .-add_delta
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
