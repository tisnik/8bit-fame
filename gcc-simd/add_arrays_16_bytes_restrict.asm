	.file	"add_arrays_16_bytes_restrict.c"
	.intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#	compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -ftree-vectorize
	.text
	.p2align 4
	.globl	add_arrays
	.type	add_arrays, @function
add_arrays:
.LFB0:
	.cfi_startproc
# add_arrays_16_bytes_restrict.c:5:         a[i] += b[i];
	movdqu	xmm1, XMMWORD PTR [rdi]	# tmp109, MEM <vector(16) unsigned char> [(unsigned char *)a_10(D)]
# add_arrays_16_bytes_restrict.c:5:         a[i] += b[i];
	movdqu	xmm0, XMMWORD PTR [rsi]	# vect__5.9_22, MEM <vector(16) unsigned char> [(unsigned char *)b_11(D)]
# add_arrays_16_bytes_restrict.c:5:         a[i] += b[i];
	paddb	xmm0, xmm1	# vect__6.10_23, tmp109
	movups	XMMWORD PTR [rdi], xmm0	# MEM <vector(16) unsigned char> [(unsigned char *)a_10(D)], vect__6.10_23
# add_arrays_16_bytes_restrict.c:7: }
	ret	
	.cfi_endproc
.LFE0:
	.size	add_arrays, .-add_arrays
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
