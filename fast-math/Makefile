outputs := \
	   no_math_errno_gcc_O0 no_math_errno_gcc_O3 no_math_errno_gcc_fast_math \
	   no_math_errno_clang_O0 no_math_errno_clang_O3 no_math_errno_clang_fast_math \
	   no_nan_gcc_O0 no_nan_gcc_O3 no_nan_gcc_fast_math \
	   no_nan_clang_O0 no_nan_clang_O3 no_nan_clang_fast_math \
	   nan_test_O0.ll nan_test_O3.ll nan_test_fast_math.ll \
	   nan_test_O0.asm nan_test_O3.asm nan_test_fast_math.asm \
	   sin_gcc_O0 sin_gcc_O3 sin_gcc_fast_math \
	   sin_clang_O0 sin_clang_O3 sin_clang_fast_math \
	   sin_fast.asm sin_slow.asm \
	   array_sum_3_O0.ll array_sum_3_O3.ll array_sum_3_fast_math.ll \
	   array_sum_3_O0.asm array_sum_3_O3.asm array_sum_3_fast_math.asm \
	   array_sum_1_gcc_O0 array_sum_1_gcc_O3 array_sum_1_gcc_fast_math \
	   array_sum_1_clang_O0 array_sum_1_clang_O3 array_sum_1_clang_fast_math \
	   array_sum_2_gcc_O0 array_sum_2_gcc_O3 array_sum_2_gcc_fast_math \
	   array_sum_2_clang_O0 array_sum_2_clang_O3 array_sum_2_clang_fast_math \
	   array_sum_3_gcc_O0 array_sum_3_gcc_O3 array_sum_3_gcc_fast_math \
	   array_sum_3_clang_O0 array_sum_3_clang_O3 array_sum_3_clang_fast_math

all:	$(outputs)

clean:
	rm -f $(outputs)

no_math_errno_gcc_O0:	no_math_errno.c
	gcc -O0 -lm $< -o $@

no_math_errno_gcc_O3:	no_math_errno.c
	gcc -O3 -lm $< -o $@

no_math_errno_gcc_fast_math:	no_math_errno.c
	gcc -O3 -ffast-math -lm $< -o $@

no_math_errno_clang_O0:	no_math_errno.c
	clang -O0 -lm $< -o $@

no_math_errno_clang_O3:	no_math_errno.c
	clang -O3 -lm $< -o $@

no_math_errno_clang_fast_math:	no_math_errno.c
	clang -O3 -ffast-math -lm $< -o $@

no_nan_gcc_O0:	no_nan.c
	gcc -O0 -lm $< -o $@

no_nan_gcc_O3:	no_nan.c
	gcc -O3 -lm $< -o $@

no_nan_gcc_fast_math:	no_nan.c
	gcc -O3 -ffast-math -lm $< -o $@

no_nan_clang_O0:	no_nan.c
	clang -O0 -lm $< -o $@

no_nan_clang_O3:	no_nan.c
	clang -O3 -lm $< -o $@

no_nan_clang_fast_math:	no_nan.c
	clang -O3 -ffast-math -lm $< -o $@

nan_test_O0.ll:	nan_test.c
	clang -O0 -S -emit-llvm $< -o $@

nan_test_O3.ll:	nan_test.c
	clang -O3 -S -emit-llvm $< -o $@

nan_test_fast_math.ll:	nan_test.c
	clang -O3 -ffast-math -S -emit-llvm $< -o $@

nan_test_O0.asm:	nan_test.c
	gcc -O0 -S -masm=intel $< -o $@

nan_test_O3.asm:	nan_test.c
	gcc -O3 -S -masm=intel $< -o $@

nan_test_fast_math.asm:	nan_test.c
	gcc -O3 -ffast-math -S -masm=intel $< -o $@

sin_gcc_O0:	sin.c
	gcc -O0 -lm $< -o $@

sin_gcc_O3:	sin.c
	gcc -O3 -lm $< -o $@

sin_gcc_fast_math:	sin.c
	gcc -O3 -ffast-math $< -o $@ -lm

sin_clang_O0:	sin.c
	clang -O0 -lm $< -o $@

sin_clang_O3:	sin.c
	clang -O3 -lm $< -o $@

sin_clang_fast_math:	sin.c
	clang -O3 -ffast-math -lm $< -o $@

sin_slow.asm:	sin.c
	gcc -S -masm=intel -O3 $< -o $@ -lm

sin_fast.asm:	sin.c
	gcc -S -masm=intel -O3 -ffast-math $< -o $@ -lm

array_sum_3_O0.ll:	array_sum_3.c
	clang -O0 -S -emit-llvm $< -o $@

array_sum_3_O3.ll:	array_sum_3.c
	clang -O3 -S -emit-llvm $< -o $@

array_sum_3_fast_math.ll:	array_sum_3.c
	clang -O3 -ffast-math -S -emit-llvm $< -o $@

array_sum_3_O0.asm:	array_sum_3.c
	gcc -O0 -S -masm=intel $< -o $@

array_sum_3_O3.asm:	array_sum_3.c
	gcc -O3 -S -masm=intel $< -o $@

array_sum_3_fast_math.asm:	array_sum_3.c
	gcc -O3 -ffast-math -S -masm=intel $< -o $@

array_sum_1_gcc_O0:	array_sum_1.c
	gcc -O0 -lm $< -o $@

array_sum_1_gcc_O3:	array_sum_1.c
	gcc -O3 -lm $< -o $@

array_sum_1_gcc_fast_math:	array_sum_1.c
	gcc -O3 -ffast-math -lm $< -o $@

array_sum_1_clang_O0:	array_sum_1.c
	clang -O0 -lm $< -o $@

array_sum_1_clang_O3:	array_sum_1.c
	clang -O3 -lm $< -o $@

array_sum_1_clang_fast_math:	array_sum_1.c
	clang -O3 -ffast-math -lm $< -o $@

array_sum_2_gcc_O0:	array_sum_2.c
	gcc -O0 -lm $< -o $@

array_sum_2_gcc_O3:	array_sum_2.c
	gcc -O3 -lm $< -o $@

array_sum_2_gcc_fast_math:	array_sum_2.c
	gcc -O3 -ffast-math -lm $< -o $@

array_sum_2_clang_O0:	array_sum_2.c
	clang -O0 -lm $< -o $@

array_sum_2_clang_O3:	array_sum_2.c
	clang -O3 -lm $< -o $@

array_sum_2_clang_fast_math:	array_sum_2.c
	clang -O3 -ffast-math -lm $< -o $@

array_sum_3_gcc_O0:	array_sum_3.c
	gcc -O0 -lm $< -o $@

array_sum_3_gcc_O3:	array_sum_3.c
	gcc -O3 -lm $< -o $@

array_sum_3_gcc_fast_math:	array_sum_3.c
	gcc -O3 -ffast-math -lm $< -o $@

array_sum_3_clang_O0:	array_sum_3.c
	clang -O0 -lm $< -o $@

array_sum_3_clang_O3:	array_sum_3.c
	clang -O3 -lm $< -o $@

array_sum_3_clang_fast_math:	array_sum_3.c
	clang -O3 -ffast-math -lm $< -o $@

