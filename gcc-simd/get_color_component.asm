	.file	"get_color_component.c"
	.intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#	compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -ftree-vectorize
	.text
	.p2align 4
	.globl	get_red_component
	.type	get_red_component, @function
get_red_component:
.LFB0:
	.cfi_startproc
# get_color_component.c:5:         red[i] = rgb[3*i];
	movups	xmm0, XMMWORD PTR [rsi]	# vect__8.10_43, MEM <vector(4) float> [(float *)rgb_12(D)]
	movups	xmm1, XMMWORD PTR [rsi+16]	# vect__8.11_45, MEM <vector(4) float> [(float *)rgb_12(D) + 16B]
	shufps	xmm1, xmm0, 10	# tmp110, vect__8.10_43,
	shufps	xmm0, xmm1, 140	# vect_shuffle3_low_49, tmp110,
	movq	xmm1, QWORD PTR [rsi+32]	# vect__8.12_48, MEM <vector(2) float> [(float *)rgb_12(D) + 32B]
	shufps	xmm1, xmm0, 165	# tmp115, vect_shuffle3_low_49,
	shufps	xmm0, xmm1, 36	# vect_shuffle3_high_50, tmp115,
# get_color_component.c:5:         red[i] = rgb[3*i];
	movups	XMMWORD PTR [rdi], xmm0	# MEM <vector(4) float> [(float *)red_13(D)], vect_shuffle3_high_50
	movss	xmm0, DWORD PTR [rsi+48]	# MEM[(float *)rgb_12(D) + 48B], MEM[(float *)rgb_12(D) + 48B]
	movss	DWORD PTR [rdi+16], xmm0	# MEM[(float *)red_13(D) + 16B], MEM[(float *)rgb_12(D) + 48B]
# get_color_component.c:7: }
	ret	
	.cfi_endproc
.LFE0:
	.size	get_red_component, .-get_red_component
	.p2align 4
	.globl	get_green_component
	.type	get_green_component, @function
get_green_component:
.LFB1:
	.cfi_startproc
# get_color_component.c:13:         green[i] = rgb[3*i+1];
	movups	xmm0, XMMWORD PTR [rsi+4]	# vect__8.25_46, MEM <vector(4) float> [(float *)rgb_12(D) + 4B]
	movups	xmm1, XMMWORD PTR [rsi+20]	# vect__8.26_48, MEM <vector(4) float> [(float *)rgb_12(D) + 20B]
	shufps	xmm1, xmm0, 10	# tmp110, vect__8.25_46,
	shufps	xmm0, xmm1, 140	# vect_shuffle3_low_52, tmp110,
	movq	xmm1, QWORD PTR [rsi+36]	# vect__8.27_51, MEM <vector(2) float> [(float *)rgb_12(D) + 36B]
	shufps	xmm1, xmm0, 165	# tmp115, vect_shuffle3_low_52,
	shufps	xmm0, xmm1, 36	# vect_shuffle3_high_53, tmp115,
# get_color_component.c:13:         green[i] = rgb[3*i+1];
	movups	XMMWORD PTR [rdi], xmm0	# MEM <vector(4) float> [(float *)green_13(D)], vect_shuffle3_high_53
	movss	xmm0, DWORD PTR [rsi+52]	# MEM[(float *)rgb_12(D) + 52B], MEM[(float *)rgb_12(D) + 52B]
	movss	DWORD PTR [rdi+16], xmm0	# MEM[(float *)green_13(D) + 16B], MEM[(float *)rgb_12(D) + 52B]
# get_color_component.c:15: }
	ret	
	.cfi_endproc
.LFE1:
	.size	get_green_component, .-get_green_component
	.p2align 4
	.globl	get_blue_component
	.type	get_blue_component, @function
get_blue_component:
.LFB2:
	.cfi_startproc
# get_color_component.c:21:         blue[i] = rgb[3*i+2];
	movups	xmm0, XMMWORD PTR [rsi+8]	# vect__8.40_46, MEM <vector(4) float> [(float *)rgb_12(D) + 8B]
	movups	xmm1, XMMWORD PTR [rsi+24]	# vect__8.41_48, MEM <vector(4) float> [(float *)rgb_12(D) + 24B]
	shufps	xmm1, xmm0, 10	# tmp110, vect__8.40_46,
	shufps	xmm0, xmm1, 140	# vect_shuffle3_low_52, tmp110,
	movq	xmm1, QWORD PTR [rsi+40]	# vect__8.42_51, MEM <vector(2) float> [(float *)rgb_12(D) + 40B]
	shufps	xmm1, xmm0, 165	# tmp115, vect_shuffle3_low_52,
	shufps	xmm0, xmm1, 36	# vect_shuffle3_high_53, tmp115,
# get_color_component.c:21:         blue[i] = rgb[3*i+2];
	movups	XMMWORD PTR [rdi], xmm0	# MEM <vector(4) float> [(float *)blue_13(D)], vect_shuffle3_high_53
	movss	xmm0, DWORD PTR [rsi+56]	# MEM[(float *)rgb_12(D) + 56B], MEM[(float *)rgb_12(D) + 56B]
	movss	DWORD PTR [rdi+16], xmm0	# MEM[(float *)blue_13(D) + 16B], MEM[(float *)rgb_12(D) + 56B]
# get_color_component.c:23: }
	ret	
	.cfi_endproc
.LFE2:
	.size	get_blue_component, .-get_blue_component
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
