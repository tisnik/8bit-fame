	.file	"add_delta_64_bytes.c"
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
	movd	xmm1, esi	# tmp110, tmp117
	lea	rax, [rdi+64]	# _11,
	punpcklbw	xmm1, xmm1	# tmp111, tmp110
	punpcklwd	xmm1, xmm1	# tmp112, tmp111
	pshufd	xmm1, xmm1, 0	# vect_cst__18, tmp112,
.L2:
# add_delta_64_bytes.c:5:         a[i] += delta;
	movdqu	xmm0, XMMWORD PTR [rdi]	# vect__3.6_17, MEM <vector(16) unsigned char> [(unsigned char *)_2]
	add	rdi, 16	# ivtmp.13,
# add_delta_64_bytes.c:5:         a[i] += delta;
	paddb	xmm0, xmm1	# vect__4.7_19, vect_cst__18
	movups	XMMWORD PTR [rdi-16], xmm0	# MEM <vector(16) unsigned char> [(unsigned char *)_2], vect__4.7_19
	cmp	rax, rdi	# _11, ivtmp.13
	jne	.L2	#,
# add_delta_64_bytes.c:7: }
	ret	
	.cfi_endproc
.LFE0:
	.size	add_delta, .-add_delta
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
