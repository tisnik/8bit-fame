	.file	"array_sqrt.c"
	.intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#	compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -ftree-vectorize
	.text
	.p2align 4
	.globl	array_sqrt
	.type	array_sqrt, @function
array_sqrt:
.LFB0:
	.cfi_startproc
	movss	xmm5, DWORD PTR .LC1[rip]	# tmp116,
	movss	xmm4, DWORD PTR .LC3[rip]	# tmp117,
	lea	rax, [rdi+96]	# _11,
# array_sqrt.c:7:         a[i] = sqrt(a[i]);
	pxor	xmm3, xmm3	# tmp110
	shufps	xmm5, xmm5, 0	# tmp116
	shufps	xmm4, xmm4, 0	# tmp117
	.p2align 6
	.p2align 4
	.p2align 3
.L2:
	movups	xmm1, XMMWORD PTR [rdi]	# vect__4.6_19, MEM <vector(4) float> [(float *)_2]
	movaps	xmm2, xmm3	# tmp111, tmp110
	add	rdi, 16	# ivtmp.13,
	rsqrtps	xmm0, xmm1	# tmp105, vect__4.6_19
	cmpneqps	xmm2, xmm1	#, tmp111, vect__4.6_19
	andps	xmm0, xmm2	# tmp105, tmp111
	mulps	xmm1, xmm0	# tmp106, tmp105
	mulps	xmm0, xmm1	# tmp107, tmp106
	mulps	xmm1, xmm4	# tmp109, tmp117
	addps	xmm0, xmm5	# tmp108, tmp116
	mulps	xmm0, xmm1	# vect__5.7, tmp109
# array_sqrt.c:7:         a[i] = sqrt(a[i]);
	movups	XMMWORD PTR [rdi-16], xmm0	# MEM <vector(4) float> [(float *)_2], vect__5.7
	cmp	rax, rdi	# _11, ivtmp.13
	jne	.L2	#,
# array_sqrt.c:9: }
	ret	
	.cfi_endproc
.LFE0:
	.size	array_sqrt, .-array_sqrt
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC1:
	.long	-1069547520
	.align 4
.LC3:
	.long	-1090519040
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
