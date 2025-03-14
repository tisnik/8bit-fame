	.file	"add_delta_size_17.c"
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
	movaps	xmm2, xmm0	# vect_cst__37, delta
	mov	rax, rdi	# ivtmp.16, a
	lea	rdx, [rdi+64]	# _21,
	shufps	xmm2, xmm2, 0	# vect_cst__37
.L2:
# add_delta_size_17.c:5:         a[i] += delta;
	movups	xmm1, XMMWORD PTR [rax]	# vect__4.8_36, MEM <vector(4) float> [(float *)_30]
	add	rax, 16	# ivtmp.16,
# add_delta_size_17.c:5:         a[i] += delta;
	addps	xmm1, xmm2	# vect__5.9_38, vect_cst__37
	movups	XMMWORD PTR [rax-16], xmm1	# MEM <vector(4) float> [(float *)_30], vect__5.9_38
	cmp	rdx, rax	# _21, ivtmp.16
	jne	.L2	#,
	addss	xmm0, DWORD PTR [rdi+64]	# _27, MEM[(float *)a_9(D) + 64B]
	movss	DWORD PTR [rdi+64], xmm0	# MEM[(float *)a_9(D) + 64B], _27
# add_delta_size_17.c:7: }
	ret	
	.cfi_endproc
.LFE0:
	.size	add_delta, .-add_delta
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
