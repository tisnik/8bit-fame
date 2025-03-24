	.file	"set_color_component.c"
	.intel_syntax noprefix
# GNU C17 (GCC) version 14.2.1 20240912 (Red Hat 14.2.1-3) (x86_64-redhat-linux)
#	compiled by GNU C version 14.2.1 20240912 (Red Hat 14.2.1-3), GMP version 6.2.1, MPFR version 4.2.1, MPC version 1.3.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -msse -mfpmath=sse -masm=intel -mtune=generic -march=x86-64 -O2 -ffast-math -ftree-vectorize
	.text
	.p2align 4
	.globl	set_red_component
	.type	set_red_component, @function
set_red_component:
.LFB0:
	.cfi_startproc
	movss	xmm0, DWORD PTR [rdi+12]	# _68, BIT_FIELD_REF <MEM <vector(4) float> [(float *)red_12(D)], 32, 96>
	movss	xmm1, DWORD PTR [rdi+8]	# _65, BIT_FIELD_REF <MEM <vector(4) float> [(float *)red_12(D)], 32, 64>
	movss	xmm2, DWORD PTR [rdi+4]	# _62, BIT_FIELD_REF <MEM <vector(4) float> [(float *)red_12(D)], 32, 32>
# set_color_component.c:5:         rgb[3*i] = red[i];
	movss	xmm3, DWORD PTR [rdi]	# BIT_FIELD_REF <MEM <vector(4) float> [(float *)red_12(D)], 32, 0>, BIT_FIELD_REF <MEM <vector(4) float> [(float *)red_12(D)], 32, 0>
	movss	DWORD PTR [rsi+36], xmm0	# MEM[(float *)rgb_13(D) + 36B], _68
	movss	xmm0, DWORD PTR [rdi+16]	# MEM[(float *)red_12(D) + 16B], MEM[(float *)red_12(D) + 16B]
	movss	DWORD PTR [rsi], xmm3	# *rgb_13(D), BIT_FIELD_REF <MEM <vector(4) float> [(float *)red_12(D)], 32, 0>
	movss	DWORD PTR [rsi+12], xmm2	# MEM[(float *)rgb_13(D) + 12B], _62
	movss	DWORD PTR [rsi+24], xmm1	# MEM[(float *)rgb_13(D) + 24B], _65
	movss	DWORD PTR [rsi+48], xmm0	# MEM[(float *)rgb_13(D) + 48B], MEM[(float *)red_12(D) + 16B]
# set_color_component.c:7: }
	ret	
	.cfi_endproc
.LFE0:
	.size	set_red_component, .-set_red_component
	.p2align 4
	.globl	set_green_component
	.type	set_green_component, @function
set_green_component:
.LFB1:
	.cfi_startproc
	movss	xmm0, DWORD PTR [rdi+12]	# _71, BIT_FIELD_REF <MEM <vector(4) float> [(float *)green_12(D)], 32, 96>
	movss	xmm1, DWORD PTR [rdi+8]	# _68, BIT_FIELD_REF <MEM <vector(4) float> [(float *)green_12(D)], 32, 64>
	movss	xmm2, DWORD PTR [rdi+4]	# _65, BIT_FIELD_REF <MEM <vector(4) float> [(float *)green_12(D)], 32, 32>
# set_color_component.c:13:         rgb[3*i+1] = green[i];
	movss	xmm3, DWORD PTR [rdi]	# BIT_FIELD_REF <MEM <vector(4) float> [(float *)green_12(D)], 32, 0>, BIT_FIELD_REF <MEM <vector(4) float> [(float *)green_12(D)], 32, 0>
	movss	DWORD PTR [rsi+40], xmm0	# MEM[(float *)rgb_13(D) + 40B], _71
	movss	xmm0, DWORD PTR [rdi+16]	# MEM[(float *)green_12(D) + 16B], MEM[(float *)green_12(D) + 16B]
	movss	DWORD PTR [rsi+4], xmm3	# MEM[(float *)rgb_13(D) + 4B], BIT_FIELD_REF <MEM <vector(4) float> [(float *)green_12(D)], 32, 0>
	movss	DWORD PTR [rsi+16], xmm2	# MEM[(float *)rgb_13(D) + 16B], _65
	movss	DWORD PTR [rsi+28], xmm1	# MEM[(float *)rgb_13(D) + 28B], _68
	movss	DWORD PTR [rsi+52], xmm0	# MEM[(float *)rgb_13(D) + 52B], MEM[(float *)green_12(D) + 16B]
# set_color_component.c:15: }
	ret	
	.cfi_endproc
.LFE1:
	.size	set_green_component, .-set_green_component
	.p2align 4
	.globl	set_blue_component
	.type	set_blue_component, @function
set_blue_component:
.LFB2:
	.cfi_startproc
	movss	xmm0, DWORD PTR [rdi+12]	# _71, BIT_FIELD_REF <MEM <vector(4) float> [(float *)blue_12(D)], 32, 96>
	movss	xmm1, DWORD PTR [rdi+8]	# _68, BIT_FIELD_REF <MEM <vector(4) float> [(float *)blue_12(D)], 32, 64>
	movss	xmm2, DWORD PTR [rdi+4]	# _65, BIT_FIELD_REF <MEM <vector(4) float> [(float *)blue_12(D)], 32, 32>
# set_color_component.c:21:         rgb[3*i+2] = blue[i];
	movss	xmm3, DWORD PTR [rdi]	# BIT_FIELD_REF <MEM <vector(4) float> [(float *)blue_12(D)], 32, 0>, BIT_FIELD_REF <MEM <vector(4) float> [(float *)blue_12(D)], 32, 0>
	movss	DWORD PTR [rsi+44], xmm0	# MEM[(float *)rgb_13(D) + 44B], _71
	movss	xmm0, DWORD PTR [rdi+16]	# MEM[(float *)blue_12(D) + 16B], MEM[(float *)blue_12(D) + 16B]
	movss	DWORD PTR [rsi+8], xmm3	# MEM[(float *)rgb_13(D) + 8B], BIT_FIELD_REF <MEM <vector(4) float> [(float *)blue_12(D)], 32, 0>
	movss	DWORD PTR [rsi+20], xmm2	# MEM[(float *)rgb_13(D) + 20B], _65
	movss	DWORD PTR [rsi+32], xmm1	# MEM[(float *)rgb_13(D) + 32B], _68
	movss	DWORD PTR [rsi+56], xmm0	# MEM[(float *)rgb_13(D) + 56B], MEM[(float *)blue_12(D) + 16B]
# set_color_component.c:23: }
	ret	
	.cfi_endproc
.LFE2:
	.size	set_blue_component, .-set_blue_component
	.ident	"GCC: (GNU) 14.2.1 20240912 (Red Hat 14.2.1-3)"
	.section	.note.GNU-stack,"",@progbits
