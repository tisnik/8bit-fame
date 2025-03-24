	.file	"add_delta_4_doubles.c"
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
# add_delta_4_doubles.c:5:         a[i] += delta;
	movupd	xmm1, XMMWORD PTR [rdi]	# vect__4.6_3, MEM <vector(2) double> [(double *)a_9(D)]
# add_delta_4_doubles.c:5:         a[i] += delta;
	movupd	xmm2, XMMWORD PTR [rdi+16]	# tmp113, MEM <vector(2) double> [(double *)a_9(D) + 16B]
	unpcklpd	xmm0, xmm0	# tmp105
	addpd	xmm1, xmm0	# vect__5.7_4, tmp105
	addpd	xmm0, xmm2	# vect__5.7_22, tmp113
	movups	XMMWORD PTR [rdi], xmm1	# MEM <vector(2) double> [(double *)a_9(D)], vect__5.7_4
	movups	XMMWORD PTR [rdi+16], xmm0	# MEM <vector(2) double> [(double *)a_9(D) + 16B], vect__5.7_22
# add_delta_4_doubles.c:7: }
	ret	
	.cfi_endproc
.LFE0:
	.size	add_delta, .-add_delta
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
