	.file	"array_clear_128_bytes.c"
	.intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#	compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -ftree-vectorize
	.text
	.p2align 4
	.globl	clear
	.type	clear, @function
clear:
.LFB0:
	.cfi_startproc
# array_clear_128_bytes.c:5:         a[i] = 0;
	mov	QWORD PTR [rdi], 0	#* a,
# array_clear_128_bytes.c:1: void clear(unsigned char *a) {
	mov	rax, rdi	# a, tmp109
# array_clear_128_bytes.c:5:         a[i] = 0;
	lea	rdi, [rdi+8]	# tmp105,
	mov	QWORD PTR [rdi+112], 0	#,
	and	rdi, -8	# tmp105,
	sub	rax, rdi	# tmp106, tmp105
	lea	ecx, [rax+128]	# tmp100,
	xor	eax, eax	# tmp101
	shr	ecx, 3	#,
	rep stosq
# array_clear_128_bytes.c:7: }
	ret	
	.cfi_endproc
.LFE0:
	.size	clear, .-clear
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
