	.file	"add_delta_32_bytes.c"
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
	movd	xmm0, esi	# tmp109, tmp118
# add_delta_32_bytes.c:5:         a[i] += delta;
	movdqu	xmm1, XMMWORD PTR [rdi]	# vect__3.6_3, MEM <vector(16) unsigned char> [(unsigned char *)a_8(D)]
# add_delta_32_bytes.c:5:         a[i] += delta;
	movdqu	xmm2, XMMWORD PTR [rdi+16]	# tmp120, MEM <vector(16) unsigned char> [(unsigned char *)a_8(D) + 16B]
	punpcklbw	xmm0, xmm0	# tmp110, tmp109
	punpcklwd	xmm0, xmm0	# tmp111, tmp110
	pshufd	xmm0, xmm0, 0	# tmp112, tmp111,
	paddb	xmm1, xmm0	# vect__4.7_4, tmp112
	paddb	xmm0, xmm2	# vect__4.7_19, tmp120
	movups	XMMWORD PTR [rdi], xmm1	# MEM <vector(16) unsigned char> [(unsigned char *)a_8(D)], vect__4.7_4
	movups	XMMWORD PTR [rdi+16], xmm0	# MEM <vector(16) unsigned char> [(unsigned char *)a_8(D) + 16B], vect__4.7_19
# add_delta_32_bytes.c:7: }
	ret	
	.cfi_endproc
.LFE0:
	.size	add_delta, .-add_delta
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
