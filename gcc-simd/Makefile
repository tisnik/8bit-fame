CC=gcc
NO_SSE_OPTS=-O2 -S -masm=intel -fverbose-asm -mno-sse
SSE_OPTS_NO_FAST_MATH=-O2 -S -msse -mfpmath=sse -fno-math-errno
SSE_OPTS=-O2 -S -msse -mfpmath=sse -ffast-math -masm=intel -fverbose-asm 
NO_VECTORIZE=-fno-tree-vectorize
VECTORIZE=-ftree-vectorize

outputs := array_clear_size_8_no_sse.asm array_clear_size_8_non_vect.asm array_clear_size_8_vect.asm \
	   array_clear_size_16_non_vect.asm array_clear_size_16_vect.asm \
	   array_clear_size_18_non_vect.asm array_clear_size_18_vect.asm \
	   add_delta_size_16_non_vect.asm add_delta_size_16_vect.asm \
	   add_delta_size_17_non_vect.asm add_delta_size_17_vect.asm \
	   add_delta_size_24_non_vect.asm add_delta_size_24_vect.asm \
	   array_sqrt_non_vect.asm array_sqrt_vect.asm array_sqrt_vect_fast_math.asm \
	   dot_product_4_non_vect.asm dot_product_4_vect.asm \
	   dot_product_8_non_vect.asm dot_product_8_vect.asm \
	   dot_product_100_non_vect.asm dot_product_100_vect.asm \
	   add_arrays_size_4_non_vect.asm add_arrays_size_4_vect.asm \
	   add_arrays_size_16_non_vect.asm add_arrays_size_16_vect.asm \
	   add_arrays_size_17_non_vect.asm add_arrays_size_17_vect.asm \
	   add_arrays_restrict_size_4_non_vect.asm add_arrays_restrict_size_4_vect.asm \
	   add_arrays_restrict_size_16_non_vect.asm add_arrays_restrict_size_16_vect.asm \
	   add_arrays_restrict_size_17_non_vect.asm add_arrays_restrict_size_17_vect.asm \
	   array_sum_4_non_vect.asm array_sum_4_vect.asm \
	   array_sum_8_non_vect.asm array_sum_8_vect.asm \
	   array_sum_100_non_vect.asm array_sum_100_vect.asm

all:	$(outputs)

clean:
	rm -f *.asm

.PHONY: all clean


array_clear_size_8_no_sse.asm:	array_clear_size_8.c
	gcc ${NO_SSE_OPTS} $< -o $@

array_clear_size_8_non_vect.asm:	array_clear_size_8.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

array_clear_size_8_vect.asm:	array_clear_size_8.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

array_clear_size_16_non_vect.asm:	array_clear_size_16.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

array_clear_size_16_vect.asm:	array_clear_size_16.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

array_clear_size_18_non_vect.asm:	array_clear_size_18.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

array_clear_size_18_vect.asm:	array_clear_size_18.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

add_delta_size_16_non_vect.asm:	add_delta_size_16.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

add_delta_size_16_vect.asm:	add_delta_size_16.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

add_delta_size_17_non_vect.asm:	add_delta_size_17.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

add_delta_size_17_vect.asm:	add_delta_size_17.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

add_delta_size_24_non_vect.asm:	add_delta_size_24.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

add_delta_size_24_vect.asm:	add_delta_size_24.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

array_sqrt_non_vect.asm:	array_sqrt.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

array_sqrt_vect.asm:	array_sqrt.c
	gcc ${SSE_OPTS_NO_FAST_MATH} ${VECTORIZE} $< -o $@

array_sqrt_vect_fast_math.asm:	array_sqrt.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

dot_product_4_non_vect.asm:	dot_product_4.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

dot_product_4_vect.asm:	dot_product_4.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

dot_product_8_non_vect.asm:	dot_product_8.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

dot_product_8_vect.asm:	dot_product_8.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

dot_product_100_non_vect.asm:	dot_product_100.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

dot_product_100_vect.asm:	dot_product_100.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

add_arrays_size_4_non_vect.asm:	add_arrays_size_4.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

add_arrays_size_4_vect.asm:	add_arrays_size_4.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

add_arrays_size_16_non_vect.asm:	add_arrays_size_16.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

add_arrays_size_16_vect.asm:	add_arrays_size_16.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

add_arrays_size_17_non_vect.asm:	add_arrays_size_17.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

add_arrays_size_17_vect.asm:	add_arrays_size_17.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

add_arrays_restrict_size_4_non_vect.asm:	add_arrays_restrict_size_4.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

add_arrays_restrict_size_4_vect.asm:	add_arrays_restrict_size_4.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

add_arrays_restrict_size_16_non_vect.asm:	add_arrays_restrict_size_16.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

add_arrays_restrict_size_16_vect.asm:	add_arrays_restrict_size_16.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

add_arrays_restrict_size_17_non_vect.asm:	add_arrays_restrict_size_17.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

add_arrays_restrict_size_17_vect.asm:	add_arrays_restrict_size_17.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

array_sum_4_non_vect.asm:	array_sum_4.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

array_sum_4_vect.asm:	array_sum_4.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

array_sum_8_non_vect.asm:	array_sum_8.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

array_sum_8_vect.asm:	array_sum_8.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@

array_sum_100_non_vect.asm:	array_sum_100.c
	gcc ${SSE_OPTS} ${NO_VECTORIZE} $< -o $@

array_sum_100_vect.asm:	array_sum_100.c
	gcc ${SSE_OPTS} ${VECTORIZE} $< -o $@
