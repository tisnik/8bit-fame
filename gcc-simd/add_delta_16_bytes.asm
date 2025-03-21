	.file	"add_delta_16_bytes.c"
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
# add_delta_16_bytes.c:5:         a[i] += delta;
	movd	xmm0, esi	# tmp108, tmp114
	movdqu	xmm1, XMMWORD PTR [rdi]	# tmp116, MEM <vector(16) unsigned char> [(unsigned char *)a_8(D)]
	punpcklbw	xmm0, xmm0	# tmp109, tmp108
	punpcklwd	xmm0, xmm0	# tmp110, tmp109
	pshufd	xmm0, xmm0, 0	# tmp111, tmp110,
	paddb	xmm0, xmm1	# vect__4.7_19, tmp116
	movups	XMMWORD PTR [rdi], xmm0	# MEM <vector(16) unsigned char> [(unsigned char *)a_8(D)], vect__4.7_19
# add_delta_16_bytes.c:7: }
	ret	
	.cfi_endproc
.LFE0:
	.size	add_delta, .-add_delta
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
