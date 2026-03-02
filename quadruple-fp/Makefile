CC=gcc

outputs := \
	   float_128_printing fp_diffs

all:	$(outputs)

clean:
	rm -f $(outputs)

float_128_printing:	float_128_printing.c
	$(CC) $< -o $@ -lquadmath

fp_diffs:	fp_diffs.c
	$(CC) $< -o $@ -lquadmath

#complex_128_arith.c
#complex_128_functions.c
#complex_128_printing.c
#complex_128_to_float_128.c
#float_128_arith.c
#float_128_constants.c
#float_128_functions.c
#float_128_printing.c
#float_128_special_values.c
#fp_diffs.c
#heron_method_double.c
#heron_method_float.c
#heron_method_quad.c
#string_to_float128.c
