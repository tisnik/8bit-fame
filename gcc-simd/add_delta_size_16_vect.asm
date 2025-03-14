	.file	"add_delta_size_16.c"
	.intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#	compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -ftree-vectorize
	.text
	.p2align 4
	.globl	add_delta
	.type	add_delta, @function
add_delta:
.LFB0:
	.cfi_startproc
	lea	rax, [rdi+64]	# _5,
	shufps	xmm0, xmm0, 0	# vect_cst__21
.L2:
# add_delta_size_16.c:5:         a[i] += delta;
	movups	xmm1, XMMWORD PTR [rdi]	# vect__4.6_20, MEM <vector(4) float> [(float *)_2]
	add	rdi, 16	# ivtmp.13,
# add_delta_size_16.c:5:         a[i] += delta;
	addps	xmm1, xmm0	# vect__5.7_22, vect_cst__21
	movups	XMMWORD PTR [rdi-16], xmm1	# MEM <vector(4) float> [(float *)_2], vect__5.7_22
	cmp	rax, rdi	# _5, ivtmp.13
	jne	.L2	#,
# add_delta_size_16.c:7: }
	ret	
	.cfi_endproc
.LFE0:
	.size	add_delta, .-add_delta
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
